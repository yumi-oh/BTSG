<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../inc/top.jsp"%>
<script type="text/javascript">
	$(function(){
		$('#frmLogin').submit(function(){
			if ($('#user_id').val().length<1){ 
				alert('아이디를 입력하세요');
				$('#user_id').focus();
				event.preventDefault();
			}else if ($('#user_password').val().length<1){
				alert('비밀번호를 입력하세요');
				$('#user_password').focus();
				event.preventDefault();
			}
		});
		$('#lg_submit').hover(function(){
			$(this).css('background-color', 'gray');
			$(this).val().css('color', 'black');
			
		}, function(){
			$(this).css('background-color', 'black');
			$(this).val().css('color', 'white');
		});;
		
	});
</script>
<%
	String ck_value="";
	Cookie[] ckArr=request.getCookies();
	if(ckArr!=null){
		for(int i=0; i<ckArr.length; i++){
			if(ckArr[i].getName().equals("ck_userid")){
				ck_value = ckArr[i].getValue();
				break;
			}
		}
	}
%>
	<article class="simpleForm"> 
		<form id ="frmLogin" name="frmLogin" method="post" action="login_ok.jsp">
			<fieldset id="log">
				<legend>LOG IN</legend>
				<div id="log_input">
					<label for="user_id" class="label">아이디</label>
					<input type="text" name="user_id" id="user_id"
					value="<%=ck_value%>">
				</div>
				<div id="log_input">
					<label for="user_password" class="label">비밀번호</label>
					<input type="password" name="user_password" id="user_password">
				</div>
				<div class="align_center">
					
					<input type="checkbox" name="chkSave" id="chkSave"
					<%if(ck_value!=null&&!ck_value.isEmpty()){%>
						checked="checked"
					<%} %>
					>
					<span id="chklabel">아이디 저장하기</span><br>
					<input type="submit" id="lg_submit" value="LOG IN"><br>
					<a href="register.jsp"><span id="regis">회원가입▶</span>
					</a>
				</div>					
			</fieldset>
			<fieldset id="sns">
			<div>
				<a href="https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=Jb2F3KDl6PViHg6sRP7i&scope=login+userinfo&state=52f137284bb8923944ae1c4b78fb8d2778ad1d38f12f02a8bf829fdd57e1553245d81ab7818e20a591e9e4118f055c16461e5d87c4d26a98771aee4467e4b52dbd3050fe340dc736e0b954568ff63c9b3171989d6810981320845a374d8dfc9981bbe4f89ba7be7b3656c966508d6eae05bdd2ec567206b9cb36c3660ccfa073&redirect_uri=https%3A%2F%2Fwww.ygselect.com%2FApi%2FMember%2FOauth2ClientCallback%2Fnaver%2F" id="sns-login">
					<img src="../assets/img/1.PNG" id="snsBtn">
				</a>
				<a href="#" id="sns-login">
					<img src="../assets/img/2.PNG" id="snsBtn">
				</a>
				<a href="#" id="sns-login">
					<img src="../assets/img/3.PNG" id="snsBtn">
				</a>
			</div>
			</fieldset>
			
		</form>
	</article>
<%@ include file="../inc/bottom.jsp"%>