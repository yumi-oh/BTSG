<%@page import="com.btsg.model.Services.UserService"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.btsg.model.DAOs.UserDAO"%>
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
	request.setCharacterEncoding("utf-8");
	String user_id = (String)session.getAttribute("user_id");
	String user_password = request.getParameter("user_password");
	
	UserService userService = new UserService();
	try{
		int result = userService.loginCheck(user_id, user_password);
		if(result==UserService.LOGIN_OK){%>
			<script type="text/javascript">
				confirm("정말 탈퇴하시겠습니까?");
			</script>
			<%int cnt = userService.deleteUser(user_id);
			if(cnt>0){
				session.invalidate();
				String ck_value="";
				Cookie[] ckArr=request.getCookies();
				if(ckArr!=null){
					for(int i=0; i<ckArr.length; i++){
						ckArr[i].setMaxAge(0);
					}
				}
				%>
				<script type="text/javascript">
					alert("회원탈퇴가 정상적으로 완료되었습니다!");
					location.href="<%=request.getContextPath()%>/main/index.jsp";
				</script>
			<%}else{%>
				<script type="text/javascript">
					alert("회원탈퇴 실패하였습니다!");
					history.back();
				</script>
			<%}
		}else{%>
			<script type="text/javascript">
				alert("비밀번호를 확인하세요!");
				history.back();
			</script>
		<%}
	}catch(SQLException e){
		e.printStackTrace();
	}
	
%>
</body>
</html>