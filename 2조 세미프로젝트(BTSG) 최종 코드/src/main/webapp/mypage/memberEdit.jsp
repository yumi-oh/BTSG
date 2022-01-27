<%@page import="com.btsg.model.DAOs.UserDAO"%>
<%@page import="com.btsg.model.VOs.UserVO"%>
<%@page import="com.btsg.model.Services.UserService"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="UserService" class="com.btsg.model.Services.UserService" scope="session"></jsp:useBean>
	
<%

	String m_user_id=(String)session.getAttribute("user_id");
	UserVO m_vo=null;
	try{
		m_vo=UserService.selectByUser_id(m_user_id);
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	
	String zipcode=m_vo.getZipcode();
	String address=m_vo.getAddress();
	String addressDetail=m_vo.getAddressDetail();
	if(zipcode==null) zipcode="";
	if(address==null) address="";
	if(addressDetail==null) addressDetail="";
	

	String hp=m_vo.getHp();
	String hp1="", hp2="", hp3="";
	if(hp!=null && !hp.isEmpty()){
		
		hp1=hp.substring(0,3);
		hp2=hp.substring(3,7);
		hp3=hp.substring(7,11);
	}
	
	String card_com=m_vo.getCard_com();
	String card_com1="";
	if(card_com!=null && !card_com.isEmpty()){
		card_com=card_com1;
	}
	
	
	String card_num=m_vo.getCard_num();
	String card_num1="", card_num2="", card_num3="", card_num4="";
	if(card_num!=null && !card_num.isEmpty()){
		
		card_num1=card_num.substring(0,4);
		card_num2=card_num.substring(5,9);
		card_num3=card_num.substring(10,14);
		card_num4=card_num.substring(15,19);
	}
	
	
	String basic_payment = m_vo.getBasic_payment();
	if(m_vo.getBasic_payment()==null) basic_payment = "";
	
	String email=m_vo.getEmail();
	String email1="", email2="";
	String[] emailList={"naver.com","hanmail.net","nate.com", "gmail.com"};
	boolean isEtc=false;
	int count=0;
	//h@nate.com, k@herb.com
	if(email!=null && !email.isEmpty()){
		String[] emailArr=email.split("@");
		email1=emailArr[0]; //h, k
		email2=emailArr[1]; //nate.com, herb.com
				
		for(String s : emailList){
			if(email2.equals(s)){
				count++;
				break;
			}
		}
		
		if(count==0){
			isEtc=true;
		}
	}
%>

<script type="text/javascript">
	$(function(){
		$('#registerFrm3').submit(function(){
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
			open("checkUserId.jsp?user_id="+id, "chkId", "width=500, height=500, left=30, top=30, resizable=yes, location=yes")
		});
		$('#btnZipcode').click(function(){
			open("../zipcode/zipcode.jsp", "zip", "width=500, height=500, left=30, top=30, resizable=yes, location=yes")
		});
	});
	
	function validate_userid(id){
		var pattern = new RegExp(/^[azA-Z0-9_]+$/g);
		
		return pattern.test(id);
	}
	
	function validate_phone(tel){
		var pattern = new RegExp(/^[0-9]*$/g);
		
		return pattern.test(tel);
	}
	var InputImage = 
		 (function loadImageFile() {
		    if (window.FileReader) {
		        var ImagePre; 
		        var ImgReader = new window.FileReader();
		        var fileType = /^(?:image\/bmp|image\/gif|image\/jpeg|image\/png|image\/x\-xwindowdump|image\/x\-portable\-bitmap)$/i; 
		 
		        ImgReader.onload = function (Event) {
		            if (!ImagePre) {
		            	
		                var newPreview = document.getElementById("imagePreview2");
		                var older = document.getElementById("older");
		                ImagePre = new Image();
		                ImagePre.style.width = "282px";
		                ImagePre.style.height = "352px";
		                newPreview.removeChild(older);
		                newPreview.appendChild(ImagePre);
		            }
		            ImagePre.src = Event.target.result;
		            
		        };
		 
		        return function () {
		         
		            var img = document.getElementById("image").files;
		           
		            if (!fileType.test(img[0].type)) { 
		             alert("이미지 파일을 업로드 하세요"); 
		             return; 
		            }
		            
		            ImgReader.readAsDataURL(img[0]);
		        }
		 
		    }
		   
		            document.getElementById("imagePreview").src = document.getElementById("image").value;
		 
		      
		})();
</script>
	<form id = "registerFrm3" method="post" name="register" action="memberEdit_ok.jsp" encType="multipart/form-data">
	<fieldset id="regi2">

		<div>        
			<label for="user_name">성명</label>
			<span><%=m_vo.getUser_name() %></span>
		</div>
		<div>
			<label for="user_id">회원ID</label>
			<span><%=m_vo.getUser_id() %></span>
		</div>
		<div>
		   <label for="user_password">비밀번호</label>
		   <input type="password" name="user_password" id="user_password1" maxlength="15" placeholder="비밀번호는 8~15자리입니다.">
		</div>
		<div>
		   <label for="user_password2">비밀번호 확인</label>
		   <input type="password" name="user_password2" id="user_password2" maxlength="15" placeholder="2차 비밀번호를 확인하세요.">
		</div>
		<div>        
		   <label for="nickname">닉네임</label>
		   <input type="text" name="nickname" id="nickname" style="ime-mode:active"
				placeholder="닉네임은 최대 8글자까지 가능합니다." value="<%=m_vo.getNickname()%>">
			<p id="nick_ok" class="nick" style="display:none">사용가능한 닉네임입니다.</p>
			<p id="nick_dup"class="nick" style="display:none">중복된 닉네임입니다.</p>
		</div>
		<div>        
			<label for="birth1">생년월일</label>
			<span><%=m_vo.getBirth()%></span>
		</div>
		<div>
		   <label for="email1">이메일 주소</label>
		   <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
			   <li><a class="dropdown-item" href="#">Action</a></li>
			   <li><a class="dropdown-item" href="#">Another action</a></li>
			   <li><a class="dropdown-item" href="#">Something else here</a></li>
			</ul>
			<input type="text" name="email1"  id="email1" title="이메일주소 앞자리"
				placeholder="example123" value="<%=email1%>"> @ 
			<select name="email2" id="email2"  title="이메일주소 뒷자리">
				<option value="naver.com"
            	<%if(email2.equals("naver.com")){ %>
            		selected="selected"
            	<%} %>
            >naver.com</option>
            <option value="hanmail.net"
            	<%if(email2.equals("hanmail.net")){ %>
            		selected="selected"
            	<%} %>
            >hanmail.net</option>
            <option value="nate.com"
            	<%if(email2.equals("nate.com")){ %>
            		selected="selected"
            	<%} %>
            >nate.com</option>
            <option value="gmail.com"
            	<%if(email2.equals("gmail.com")){ %>
            		selected="selected"
            	<%} %>
            >gmail.com</option>
            <option value="etc"
            	<%if(isEtc){ %>
            		selected="selected"
            	<%} %>            	
            >직접입력</option>
			</select>
			<input type="text" name="email3" id="email3" title="직접입력인 경우 이메일주소 뒷자리"
           	<%if(isEtc){ %>
	        	style="visibility:visible;"
	        	value="<%=email2 %>"
           	<%}else{ %>
        		style="visibility:hidden"
        	<%} %>
        	>
		</div> 
		 <div>
			<label for="hp1">핸드폰</label>&nbsp;
        <select name="hp1" id="hp1" title="휴대폰 앞자리">
            <option value="010" 
            	<%if(hp1.equals("010")){ %>
            		selected="selected"
            	<%} %>
            >010</option>
            <option value="011"
            	<%if(hp1.equals("011")){ %>
            		selected="selected"
            	<%} %>
            >011</option>
            <option value="016"
            	<%if(hp1.equals("016")){ %>
            		selected="selected"
            	<%} %>
            >016</option>
            <option value="017"
            	<%if(hp1.equals("017")){ %>
            		selected="selected"
            	<%} %>
            >017</option>
            <option value="018"
            	<%if(hp1.equals("018")){ %>
            		selected="selected"
            	<%} %>
            >018</option>
            <option value="019"
            	<%if(hp1.equals("019")){ %>
            		selected="selected"
            	<%} %>
            >019</option>
       	</select>
			&nbsp;-&nbsp;
			<input type="text" name="hp2" id="hp2" maxlength="4" title="휴대폰 가운데자리" 
			placeholder="8117" value="<%=hp2%>">&nbsp;-&nbsp;
			<input type="text" name="hp3" id="hp3" maxlength="4" title="휴대폰 뒷자리" 
			placeholder="8422" value="<%=hp3%>">
		</div>
	</fieldset>
	<fieldset id="regi2">
	<div>        
		<label for="upload_name">프로필사진</label>
		<input name ="upload_name" id="image" type="file" onchange="InputImage();" 
		value="<%=m_vo.getUpload_name()%>">
	</div>
	<div id="zip2">
		<label for="zipcode">주소</label>
		<input type="text" name="zipcode" id="zipcode" ReadOnly  
			title="우편번호" placeholder="우편번호를 검색하세요." value="<%=zipcode %>">
		<input type="button" value="우편번호 찾기" id="btnZipcode" title="새창열림"><br />
		<span class="sp1">&nbsp;</span>
		<input type="text" name="address" ReadOnly title="주소" 
		placeholder="서울특별시 은평구 신사동 15-4" value="<%=address %>"><br />
		<span class="sp1">&nbsp;</span>
		<input type="text" name="addressDetail" title="상세주소" 
		placeholder="ABC아파트 102동 1102호" value="<%=addressDetail %>">
	</div>
	<div>
		<label for="basic_payment">기본결제별칭</label>
		<input type="text" name="basic_payment" id="basic_payment" title="기본결제수단"
			placeholder="카카오뱅크 체크" value="<%=basic_payment%>">
	</div>
	<div>
		<label for="card_com">카드사</label>
		<select name="card_com" id="card_com" title="카드사" >
			<option value="BC"
			<%if(card_com1.equals("BC")){ %>
            		selected="selected"
            	<%} %>
			>BC</option>
			<option value="master"
			<%if(card_com1.equals("master")){ %>
            		selected="selected"
            	<%} %>
			>master</option>
			<option value="unionPay"
			<%if(card_com1.equals("unionPay")){ %>
            		selected="selected"
            	<%} %>
			>union pay</option>
		</select>
	</div>
	 <div>        
		<label for="card_num">카드번호</label>
		<input type="text" name="card_num1" id="card_num1" maxlength="4" 
		value="<%=card_num1 %>">&nbsp;-&nbsp;
		<input type="text" name="card_num2" id="card_num2" maxlength="4" 
		value="<%=card_num2 %>">&nbsp;-&nbsp;
		<input type="text" name="card_num3" id="card_num3" maxlength="4" 
		 value="<%=card_num3 %>">&nbsp;-&nbsp;
		<input type="password" name="card_num4" id="card_num4" maxlength="4" 
		value="<%=card_num4 %>">
	</div>
	<div class="regi_addi">
			<input type="submit" id="submit" value="수정 완료" value="<%=m_vo.getUpload_name()%>">
	</div>
			<input type="hidden" name="user_id" value="">
	</fieldset>
	
</form>
<div id="pro">
		<fieldset id="regi_pro2">
			<div id="imagePreview2">
				<%
				String upload_name = m_vo.getUpload_name();
				if(upload_name!=null) {%>
					<img src="<%=request.getContextPath() %>/btsg_upload/<%=m_vo.getUpload_name()%>" width="282" height="352" id="older">
				<%}else{ %>
					<img src="<%=request.getContextPath() %>/assets/img/default_profile.jpg" width="282" height="352" id="older">
				<% }%>
			</div><br>
			<h3>프로필 사진 미리보기</h3>
			
		</fieldset>
</div>
