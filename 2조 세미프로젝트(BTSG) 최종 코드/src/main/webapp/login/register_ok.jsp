<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:useBean id="userVO" class="com.btsg.model.VOs.UserVO" scope="page"></jsp:useBean>
<jsp:useBean id="userService" class="com.btsg.model.Services.UserService" scope="session"></jsp:useBean>

<%
	//register.jsp에서 post방식
	request.setCharacterEncoding("utf-8");
	
	String user_name = request.getParameter("user_name");
	String user_id = request.getParameter("user_id");
	String user_password = request.getParameter("user_password");
	String nickname = request.getParameter("nickname");
	String birth1 = request.getParameter("birth1");
	String birth2 = request.getParameter("birth2");
	String hp1 = request.getParameter("hp1");
	String hp2 = request.getParameter("hp2");
	String hp3 = request.getParameter("hp3");
	String email1 = request.getParameter("email1");
	String email2 = request.getParameter("email2");
	String email3 = request.getParameter("email3");
	
	String email="", hp="", birth=birth1+"-"+birth2;
	if(hp2!=null&& !hp2.isEmpty() && hp3!=null&& !hp3.isEmpty()){
		hp=hp1+hp2+hp3;
	}
	
	if(email1!=null&&!email1.isEmpty()){
		if(email2.equals("etc")){
			if(email3!=null&&!email3.isEmpty()){
				email=email1+"@"+email3;			
			}
		}else{			
			email=email1+"@"+email2;
		}
	}
	String msg="", url="";
	//2
	try{
		userVO.setUser_name(user_name);
		userVO.setUser_password(user_password);
		userVO.setUser_id(user_id);
		userVO.setNickname(nickname);
		userVO.setHp(hp);
		userVO.setEmail(email);
		userVO.setBirth(birth);
		
		
		int cnt = userService.insertUser(userVO);
		
		if(cnt>0){
			msg="회원가입되었습니다.";
			url="../login/register_additional.jsp?user_id="+userVO.getUser_id();
		}else{
			msg="회원가입 실패!";
			url="register.jsp";
		}
	}catch(SQLException e){
		e.printStackTrace();
	}
	request.setAttribute("msg", msg);
	request.setAttribute("url", url);
	request.setAttribute("user_id", userVO.getUser_id());
%>

<jsp:forward page="../common/message.jsp"></jsp:forward>
	 
</body>
</html>