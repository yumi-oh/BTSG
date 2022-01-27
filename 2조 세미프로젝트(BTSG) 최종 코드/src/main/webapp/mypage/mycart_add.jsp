<%@page import="com.btsg.model.VOs.MycartVO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.btsg.model.DAOs.MyCartDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String user_no = (String)session.getAttribute("user_no");
	String concert_no = request.getParameter("concert_no");
	
	MyCartDAO myDao = new MyCartDAO();
	MycartVO myVo = null;
	try{
		myVo = new MycartVO();
		myVo.setConert_no(Integer.parseInt(concert_no));
		myVo.setUser_no(Integer.parseInt(user_no));
		int cnt = myDao.insertMyCart(myVo);
		if(cnt>0){%>
			<script type="text/javascript">
				alert("찜목록에 저장되었습니다.");
				location.href="<%=request.getContextPath()%>/mypage/mypage.jsp";
			</script>
			
		<%}else{%>
			<script type="text/javascript">
				alert("등록에 실패하였습니다.");
				history.back();
			</script>
		<%}
	}catch(SQLException e){
		e.printStackTrace();
	}
%>
</body>
</html>