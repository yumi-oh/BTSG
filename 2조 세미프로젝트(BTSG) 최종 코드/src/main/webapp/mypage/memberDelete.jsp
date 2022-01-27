<%@page import="com.btsg.model.VOs.UserVO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.btsg.model.DAOs.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<form id = "memberout" method="post" name="out" action="memberDelete_ok.jsp">
	<div class="input-group mb-3" id="out">
		<span id="real">비밀번호를 입력하세요.</span>
	  <span class="input-group-text"  id="basic-addon1">비밀번호 입력</span>
	  <input type="text" class="form-control" name="user_password" placeholder="비밀번호 입력" aria-label="Username" aria-describedby="basic-addon1">
	</div>
</form>
</body>
</html>