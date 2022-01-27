<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../inc/top.jsp" %>
<jsp:useBean id="userVO" class="com.btsg.model.VOs.UserVO" scope="session"></jsp:useBean>
<jsp:useBean id="userService" class="com.btsg.model.Services.UserService" scope="session"></jsp:useBean>
<%
	String user_id=request.getParameter("user_id");

	try{
		userVO = userService.selectByUser_id(user_id);		
	}catch(SQLException e){
		e.printStackTrace();
	}
%>
<div id="regi_additional">
	<h2><%=userVO.getUser_name() %>님! BTSG의 회원이 되신 것을 환영합니다! </h2>
	<h3>원활한 쇼핑몰 이용을 위한 부가적인 정보를 입력하시겠습니까? </h3>
	<br>
	<h4>(부가정보입력은 '로그인' > '마이페이지' > '내 정보수정'에서 가능합니다.) </h4>
	<br>
	<div id="go_addi" >
	<a href="additional_info.jsp?user_id=<%=userVO.getUser_id()%>" class="btn btn-primary btn-lg" tabindex="-1" role="button" aria-disabled="true">부가정보 입력하기</a>
	</div>
	<div id="go_log">
	<a href="login.jsp" class="btn btn-secondary btn-lg" tabindex="-1" role="button" aria-disabled="true">로그인하기</a>
	</div>
</div>
<%@ include file="../inc/bottom.jsp" %>