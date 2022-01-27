<%@page import="com.btsg.model.Services.UserService"%>
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
	//login.jsp에서 post방식으로 서브밋
	//1
	request.setCharacterEncoding("utf-8");
	String user_id=request.getParameter("user_id");
	String user_password=request.getParameter("user_password");
	String chkSave=request.getParameter("chkSave");
	
	//2
	String msg="로그인 처리 실패", url="login.jsp";
	try{
		int result=userService.loginCheck(user_id, user_password);
		if(result==UserService.LOGIN_OK){
			userVO=userService.selectByUser_id(user_id);
			
			String user_no=userVO.getUser_no()+"";
			session.setAttribute("user_id", user_id);
			session.setAttribute("user_name", userVO.getUser_name());
			session.setAttribute("user_no", user_no);
			
			
			if(chkSave != null ){
				Cookie ck = new Cookie("ck_userid", user_id);
				ck.setMaxAge(10000*24*60*60);
				ck.setPath("/");
				response.addCookie(ck);
			}else{
				Cookie ck = new Cookie("ck_userid", user_id);
				ck.setMaxAge(0); 
				ck.setPath("/");
				response.addCookie(ck);				
			}
			
			msg= userVO.getUser_name()+ "님 환영합니다.";
			
			url="../main/index.jsp";
			if(user_id.equals("admin")){
				url="../concert/concertList.jsp";
			}
		}else if(result==UserService.DISAGREE_PWD){
			msg="비밀번호가 일치하지 않습니다.";	
		}else if(result==UserService.USERID_NONE){
			msg="아이디가 존재하지 않습니다.";
		}
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	request.setAttribute("msg", msg);
	request.setAttribute("url", url);
%>
<jsp:forward page="../common/message.jsp"></jsp:forward>
</body>
</html>