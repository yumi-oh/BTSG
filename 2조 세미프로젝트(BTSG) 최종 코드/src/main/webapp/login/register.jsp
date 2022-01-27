<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../inc/top.jsp" %>

<script type="text/javascript">
	$(function(){
		$('#registerFrm').submit(function(){
			if($('#user_name').val().length<1){
				alert('이름을 입력하세요');
				$('#user_name').focus();
				event.preventDefault();
			}else if ($('#user_id').val().length<1){ 
				alert('아이디를 입력하세요');
				$('#user_id').focus();
				event.preventDefault();
			}else if (!validate_userid($('#user_id').val())){
				alert('아이디는 영문, 숫자, _만 가능합니다.');
				$('#userid').focus();
				event.preventDefault();
			}else if($('#chkId').val()!='Y'){
				alert('아이디 중복확인을 하세요!');
				$('#btnChkId').focus();
				event.preventDefault();
			}else if ($('#user_password1').val().length==0){
				alert('비밀번호를 입력하세요. ');
				$('#user_password1').focus();
				event.preventDefault();
			}else if ($('#user_password1').val().length>0&&$('#user_password1').val().length<8){
				alert('비밀번호는 영문, 숫자 포함 8자리 이상입니다. ');
				$('#user_password1').focus();
				event.preventDefault();
			}else if ($('#user_password2').val().length<1){
				alert('2차 비밀번호를 입력하세요');
				$('#user_password2').focus();
				event.preventDefault();
			}else if($('#user_password1').val()!==$('#user_password2').val()){
				alert('2차 비밀번호가 일치하지 않습니다.');
				$('#user_password2').focus();
				event.preventDefault();
			}else if ($('#nickname').val().length<1){
				alert('닉네임은 필수 입력사항입니다.');
				$('#nickname').focus();
				event.preventDefault();
			}else if($('#birth1').val().length<1 ||$('#birth2').val().length<1 ){
				alert('생년월일 입력을 완료해주세요.');
				$('#birth1').focus();
				event.preventDefault();
			}else if ($('#email1').val().length<1){
				alert('이메일은 필수 입력사항입니다.');
				$('#email1').focus();
				event.preventDefault();
			}else if ($('#email2 option:selected').val()=="etc"&&$('#email3').val().length<1){
				alert('이메일 입력을 완료해주세요.');
				$('#email3').focus();
				event.preventDefault();
			}else if ($('#hp2').val().length==0|| $('#hp3').val().length==0){
				alert('전화번호는 필수입력사항입니다.');
				$('#hp2').focus();
				event.preventDefault();
			}else if ($('#hp2').val().length>0 && $('#hp2').val().length<3){
				alert('유효하지 않은 전화번호입니다.');
				$('#hp2').focus();
				event.preventDefault();
			}else if ($('#hp3').val().length>0 && $('#hp2').val().length<4){
				alert('유효하지 않은 전화번호입니다.');
				$('#hp3').focus();
				event.preventDefault();
			}else if (!validate_phone($('#hp2').val()) || !validate_phone($('#hp3').val())){
				alert('전화번호는 숫자만 가능합니다.');
				$('#hp2').focus();
				event.preventDefault();
			}else if(!$('#agree1').is(':checked')){
				alert('이용약관에 동의해야합니다.');
				$('#agree1').focus();
				event.preventDefault();
			}else if(!$('#agree2').is(':checked')){
				alert('개인정보 제 3자 제공에 동의해야합니다.');
				$('#agree2').focus();
				event.preventDefault();
			}
		});
		$('#agree4').click(function(){
			$('#pro').find('input[type=checkbox]').each(function(){
				if(!$(this).is(':checked')){
					$(this).attr("checked", true);
					
				}else{
					$(this).attr("checked", false);
				}
			});
		});
		

		$('#email2').change(function(){
			if($(this).val()==='etc'){
				$('#email3').val('');
				$('#email3').css('visibility', 'visible');
				$('#email3').focus();
			}else{
				$('#email3').css('visibility', 'hidden');
			}
		});
		$('#btnChkId').click(function(){
			var id= $('#user_id').val();
			console.log(id);
				if(id==""){
				open("<%=request.getContextPath()%>/login/checkUserId.jsp?user_id="+id, "chkId", "width=500, height=500, left=30, top=30, resizable=yes, location=yes");	
			}else if (!validate_userid(id)){
				alert('아이디는 영문, 숫자, _만 가능합니다.');
				$('#user_id').focus();
				event.preventDefault();
			}else{ 
			open("<%=request.getContextPath()%>/login/checkUserId.jsp?user_id="+id, "chkId", "width=500, height=500, left=30, top=30, resizable=yes, location=yes");
			 } 
		});
		
	});
	
	function validate_userid(id){
		var pattern = new RegExp(/^[a-zA-Z0-9\s]+$/g);
		
		return pattern.test(id);
	}
	
	function validate_phone(tel){
		var pattern = new RegExp(/^[0-9]*$/g);
		
		return pattern.test(tel);
	}
</script>
	<form id = "registerFrm" method="post" name="register" action="register_ok.jsp">
		<fieldset id="regi">
			<legend>SIGN UP</legend>
			<div>        
		        <label for="user_name">성명</label>
		        <input type="text" name="user_name" id="user_name" style="ime-mode:active"
		        placeholder="예)강유빈">
		    </div>
		    <div>
		        <label for="user_id">회원ID</label>
		        <input type="text" name="user_id" id="user_id"
		        		style="ime-mode:inactive" placeholder="영문, 숫자, _포함 15자리" maxlength="15">&nbsp;
		        <input class="btn btn-primary" type="button" value="중복확인" id="btnChkId" title="새창열림">
		    </div>
		    <div>
		        <label for="user_password">비밀번호</label>
		        <input type="password" name="user_password" id="user_password1" maxlength="15" placeholder="비밀번호는 8~15자리입니다.">
		    </div>
		    <div>
		        <label for="user_password2">비밀번호 확인</label>
		        <input type="password" name="user_password2" id="user_password2" placeholder="2차 비밀번호를 확인하세요.">
		    </div>
		    <div>        
		        <label for="nickname">닉네임</label>
		        <input type="text" name="nickname" id="nickname" style="ime-mode:active"
		        	placeholder="닉네임은 최대 8글자까지 가능합니다.">
		        <p id="nick_ok" class="nick" style="display:none">사용가능한 닉네임입니다.</p>
		        <p id="nick_dup"class="nick" style="display:none">중복된 닉네임입니다.</p>
		    </div>
		    <div>        
		        <label for="birth1">생년월일</label>
		        <input type="text" name="birth1" id="birth1" style="ime-mode:active"
		        	placeholder="예)950314">&nbsp;-&nbsp;&nbsp;
		        <input type="password" name="birth2" id="birth2" maxlength="1" style="ime-mode:active" placeholder="●"><span id="ssn">●●●●●●</span>
		    </div>
		     <div>
		        <label for="email1">이메일 주소</label>
		        <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
				    <li><a class="dropdown-item" href="#">Action</a></li>
				    <li><a class="dropdown-item" href="#">Another action</a></li>
				    <li><a class="dropdown-item" href="#">Something else here</a></li>
				</ul>
		        <input type="text" name="email1"  id="email1" title="이메일주소 앞자리"
		        placeholder="example123"> @ 
		        <select name="email2" id="email2"  title="이메일주소 뒷자리">
		            <option value="hanmail.net">hanmail.net</option>
		            <option value="nate.com">nate.com</option>
		            <option value="gmail.com">gmail.com</option>
		            <option value="etc">직접입력</option>
		        </select>
		        <input type="text" name="email3" id="email3" title="직접입력인 경우 이메일주소 뒷자리"
		        	style="visibility:hidden">
		    </div> 
		     <div>
		        <label for="hp1">핸드폰</label>&nbsp;<select name="hp1" id="hp1" title="휴대폰 앞자리">
		            <option value="010">010</option>
		            <option value="011">011</option>
		            <option value="016">016</option>
		            <option value="017">017</option>
		            <option value="018">018</option>
		            <option value="019">019</option>
		       	</select>
		        &nbsp;-&nbsp;
		        <input type="text" name="hp2" id="hp2" maxlength="4" title="휴대폰 가운데자리" placeholder="8117">&nbsp;-&nbsp;
		        <input type="text" name="hp3" id="hp3" maxlength="4" title="휴대폰 뒷자리" placeholder="8422">
		    </div>
		    
		</fieldset>
		<fieldset id="pro">
			<div id="m">
				<iframe src="agreement1.html" width="600px" height="280px"></iframe>
				<input type="checkbox" id="agree1" name ="agree1"><label for="agree1">
					<span id="agreement">BTSG 이용약관</span></label>
				<iframe src="agreement2.html" width="600px" height="280px"></iframe>
				<input type="checkbox" id="agree2" name ="agree2"><label for="agree2">
					<span id="agreement">개인정보 제3자 제공</span></label>
					<br>
			</div>
			<div id="m">
				<input type="checkbox" id="agree3" name ="agree3"><label for="agree3">
					<span id="agreement">마케팅 수신에 동의합니다.</span></label>
					<br>
					<br>
				<input type="checkbox" id="agree4" name ="agree4"><label for="agree4">
					<span id="agreement">모든 약관에 동의합니다.(필수, 선택)</span></label>
			</div>
			<div class="center">
		         <input type="submit" id="wr_submit" value="SIGN UP">
		    </div>
		</fieldset>
		
    <input type ="hidden" name="chkId" id="chkId">
</form>
<%@ include file="../inc/bottom.jsp" %>