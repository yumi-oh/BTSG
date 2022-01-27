<%@page import="com.btsg.model.VOs.ConcertVO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.btsg.model.DAOs.ConcertDAO"%>
<%@page import="com.btsg.model.VOs.ConcertListVO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.btsg.model.DAOs.MyCartDAO"%>
<%@page import="com.btsg.model.VOs.MycartVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	String user_no =(String)session.getAttribute("user_no");
	

	MyCartDAO dao=new MyCartDAO();
	List<MycartVO> list=null;
	
	try{
		list=dao.selectByNo(Integer.parseInt(user_no));
		System.out.println(user_no);
	}catch(SQLException e){
		e.printStackTrace();
	}

	
	DecimalFormat df=new DecimalFormat("#,###");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
%>

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
<title>Insert title here</title>
</head>
<body>
	
	<div id="container">
	
	<!-- 반복 시작 -->
	<%	ConcertDAO conDao = new ConcertDAO();
		for(int i=0;i<list.size();i++){
			MycartVO vo=list.get(i); 
			ConcertVO concertVo= conDao.selectByNo(vo.getConert_no());
			%>
			<div id="concert">
			<a href="<%=request.getContextPath() %>/concert/concert_detail.jsp?concert_no=<%=vo.getConert_no() %>">
			
			<img alt="" src="<%=concertVo.getUpload_name()%>">
					<p><%=concertVo.getConcert_name()%></p>
					<p><%=df.format(concertVo.getPrice())%></p>	
				<p><%=sdf.format(concertVo.getStart_date())%> ~ <%=sdf.format(concertVo.getEnd_date()) %></P>	
			</a>
			</div>
	<%	}//for 	%>
	<!-- 반복 끝 -->	
	</div>
		    
	
</body>
</html>