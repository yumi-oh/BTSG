<%@page import="com.btsg.model.Services.UserService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.SQLException"%>

<jsp:useBean id="userService" class="com.btsg.model.Services.UserService" scope="session"></jsp:useBean>
<%
	request.setCharacterEncoding("utf-8");
	String user_id=request.getParameter("user_id");
	
	//2
	int result=0;
	if(user_id!=null && !user_id.isEmpty()){
		try{
			result=userService.duplicatedId(user_id);
		}catch(SQLException e){
			e.printStackTrace();
		}
	}
	
	//3
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>checkUserid.jsp</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/inc/css/top.css"/>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(function(){
		$("#submit").click(function(){	
			if($('#user_id').val().length<1){ 
				alert("아이디를 입력하세요"); 
				$('#user_id').focus(); 
				event.preventDefault(); 
			}
		});

		$('#btUse').click(function(){
			$(opener.document).find('#user_id').val('<%=user_id%>');
			$(opener.document).find('#chkId').val('Y');
			
			self.close();
		});
	});
</script>	
</head>
<body>

	<h2>아이디 중복 검사</h2><br>
	<form name="frmId" method="post" action="checkUserId.jsp">
		<input type="text" name="user_id" id="user_id" 
			title="아이디입력" value="<%=user_id%>">
		<input type="submit"  id="submit" value="아이디 확인">
		
		<%if(result==UserService.EXIST_ID){%>
			<p>이미 등록된 아이디입니다. 다른 아이디를 입력하세요</p>	
		<%}else if(result==UserService.NON_EXIST_ID){	%>
			<input type="button" value="사용하기" id="btUse">
			<p>사용가능한 아이디입니다. [사용하기] 버튼을 클릭하세요</p>			
		<%} %>
	</form>
	
</body>
</html>