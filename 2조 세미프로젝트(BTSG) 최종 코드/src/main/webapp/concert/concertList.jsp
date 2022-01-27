<%@page import="com.btsg.model.VOs.ConcertListVO"%>
<%@page import="com.btsg.model.DAOs.ConcertDAO"%>
<%@page import="com.btsg.model.VOs.ConcertVO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.util.List"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String user_id = (String)session.getAttribute("user_id");	
	if(!"admin".equals(user_id)||user_id==null){%>
	    <%@ include file="../inc/top.jsp" %>
	<%}else{%>
		<%@ include file="../admin/top.jsp" %>	
		
	<%} %>
<%
	//[1]pdWrite.jsp에서 [상품목록] 링크를 클릭하면 get방식으로 이동 
	//또는 [2]pdWrite_ok.jsp에서 상품등록 성공하면 get방식으로 이동
			
	//1.	
	//2.
	
	ConcertDAO dao = new ConcertDAO();
	List<ConcertListVO> list=null;
	try{
		list=dao.selectAll();
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	//3.
	DecimalFormat df=new DecimalFormat("#,###");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
%>
<!DOCTYPE html>
<style>
a{
text-decoration: none;
}<!-- a태그 밑줄제거 -->

<!-- 상품목록 컨테이너 -->
#contaner{
display: flex;
}


#concert{
	text-align:center;
	float:left;
	margin-right: 5px;
	width: 300px;
	text-decoration:none;
}
<!-- 상품목록 안 상품div  -->

<!-- 상품목록 안 p -->
#concert p{
margin-top:3px;
text-decoration: none;
}
#concert img{
width:100px;
height: 150px;
}<!--콘서트 이미지-->

div p{
    width: [width of img];
 }<!--콘서트 이미지와 div안의 p넓이 맞춤-->

 
</style>
<html>
<head>
<meta charset="UTF-8">
</head>
<body>


	<div id="container">
	<div id="list" style="font-size:30px; text-align:center;margin-bottom: 100px;">콘서트</div>
	<!-- 반복 시작 -->
	<%
		for(int i=0;i<list.size();i++){
			ConcertListVO vo=list.get(i); %>
			<div id="concert">
			<a href="concert_detail.jsp?concert_no=<%=vo.getConcert_no()%>">
			<img alt="" src="<%=vo.getUpload_name()%>">
					<p><%=vo.getConcert_name()%></p>
					<p><%=df.format(vo.getPrice())%></p>	
				<p><%=sdf.format(vo.getStart_date())%> ~ <%=sdf.format(vo.getEnd_date()) %></P>	
			</a>
			</div>
	<%	}//for 	%>
	<!-- 반복 끝 -->	
	</div>
</body>
</html>
<%@ include file="../inc/bottom.jsp" %>
