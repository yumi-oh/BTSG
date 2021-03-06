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
				alert('????????? ???????????????');
				$('#user_name').focus();
				event.preventDefault();
			}else if ($('#user_id').val().length<1){ 
				alert('???????????? ???????????????');
				$('#user_id').focus();
				event.preventDefault();
			}else if (!validate_userid($('#user_id').val())){
				alert('???????????? ??????, ??????, _??? ???????????????.');
				$('#userid').focus();
				event.preventDefault();
			}else if($('#chkId').val()!='Y'){
				alert('????????? ??????????????? ?????????!');
				$('#btnChkId').focus();
				event.preventDefault();
			}else if ($('#user_password1').val().length==0){
				alert('??????????????? ???????????????. ');
				$('#user_password1').focus();
				event.preventDefault();
			}else if ($('#user_password1').val().length>0&&$('#user_password1').val().length<8){
				alert('??????????????? ??????, ?????? ?????? 8?????? ???????????????. ');
				$('#user_password1').focus();
				event.preventDefault();
			}else if ($('#user_password2').val().length<1){
				alert('2??? ??????????????? ???????????????');
				$('#user_password2').focus();
				event.preventDefault();
			}else if($('#user_password1').val()!==$('#user_password2').val()){
				alert('2??? ??????????????? ???????????? ????????????.');
				$('#user_password2').focus();
				event.preventDefault();
			}else if ($('#nickname').val().length<1){
				alert('???????????? ?????? ?????????????????????.');
				$('#nickname').focus();
				event.preventDefault();
			}else if($('#birth1').val().length<1 ||$('#birth2').val().length<1 ){
				alert('???????????? ????????? ??????????????????.');
				$('#birth1').focus();
				event.preventDefault();
			}else if ($('#email1').val().length<1){
				alert('???????????? ?????? ?????????????????????.');
				$('#email1').focus();
				event.preventDefault();
			}else if ($('#email2 option:selected').val()=="etc"&&$('#email3').val().length<1){
				alert('????????? ????????? ??????????????????.');
				$('#email3').focus();
				event.preventDefault();
			}else if ($('#hp2').val().length==0|| $('#hp3').val().length==0){
				alert('??????????????? ???????????????????????????.');
				$('#hp2').focus();
				event.preventDefault();
			}else if ($('#hp2').val().length>0 && $('#hp2').val().length<3){
				alert('???????????? ?????? ?????????????????????.');
				$('#hp2').focus();
				event.preventDefault();
			}else if ($('#hp3').val().length>0 && $('#hp2').val().length<4){
				alert('???????????? ?????? ?????????????????????.');
				$('#hp3').focus();
				event.preventDefault();
			}else if (!validate_phone($('#hp2').val()) || !validate_phone($('#hp3').val())){
				alert('??????????????? ????????? ???????????????.');
				$('#hp2').focus();
				event.preventDefault();
			}else if(!$('#agree1').is(':checked')){
				alert('??????????????? ?????????????????????.');
				$('#agree1').focus();
				event.preventDefault();
			}else if(!$('#agree2').is(':checked')){
				alert('???????????? ??? 3??? ????????? ?????????????????????.');
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
		             alert("????????? ????????? ????????? ?????????"); 
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
			<label for="user_name">??????</label>
			<span><%=m_vo.getUser_name() %></span>
		</div>
		<div>
			<label for="user_id">??????ID</label>
			<span><%=m_vo.getUser_id() %></span>
		</div>
		<div>
		   <label for="user_password">????????????</label>
		   <input type="password" name="user_password" id="user_password1" maxlength="15" placeholder="??????????????? 8~15???????????????.">
		</div>
		<div>
		   <label for="user_password2">???????????? ??????</label>
		   <input type="password" name="user_password2" id="user_password2" maxlength="15" placeholder="2??? ??????????????? ???????????????.">
		</div>
		<div>        
		   <label for="nickname">?????????</label>
		   <input type="text" name="nickname" id="nickname" style="ime-mode:active"
				placeholder="???????????? ?????? 8???????????? ???????????????." value="<%=m_vo.getNickname()%>">
			<p id="nick_ok" class="nick" style="display:none">??????????????? ??????????????????.</p>
			<p id="nick_dup"class="nick" style="display:none">????????? ??????????????????.</p>
		</div>
		<div>        
			<label for="birth1">????????????</label>
			<span><%=m_vo.getBirth()%></span>
		</div>
		<div>
		   <label for="email1">????????? ??????</label>
		   <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
			   <li><a class="dropdown-item" href="#">Action</a></li>
			   <li><a class="dropdown-item" href="#">Another action</a></li>
			   <li><a class="dropdown-item" href="#">Something else here</a></li>
			</ul>
			<input type="text" name="email1"  id="email1" title="??????????????? ?????????"
				placeholder="example123" value="<%=email1%>"> @ 
			<select name="email2" id="email2"  title="??????????????? ?????????">
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
            >????????????</option>
			</select>
			<input type="text" name="email3" id="email3" title="??????????????? ?????? ??????????????? ?????????"
           	<%if(isEtc){ %>
	        	style="visibility:visible;"
	        	value="<%=email2 %>"
           	<%}else{ %>
        		style="visibility:hidden"
        	<%} %>
        	>
		</div> 
		 <div>
			<label for="hp1">?????????</label>&nbsp;
        <select name="hp1" id="hp1" title="????????? ?????????">
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
			<input type="text" name="hp2" id="hp2" maxlength="4" title="????????? ???????????????" 
			placeholder="8117" value="<%=hp2%>">&nbsp;-&nbsp;
			<input type="text" name="hp3" id="hp3" maxlength="4" title="????????? ?????????" 
			placeholder="8422" value="<%=hp3%>">
		</div>
	</fieldset>
	<fieldset id="regi2">
	<div>        
		<label for="upload_name">???????????????</label>
		<input name ="upload_name" id="image" type="file" onchange="InputImage();" 
		value="<%=m_vo.getUpload_name()%>">
	</div>
	<div id="zip2">
		<label for="zipcode">??????</label>
		<input type="text" name="zipcode" id="zipcode" ReadOnly  
			title="????????????" placeholder="??????????????? ???????????????." value="<%=zipcode %>">
		<input type="button" value="???????????? ??????" id="btnZipcode" title="????????????"><br />
		<span class="sp1">&nbsp;</span>
		<input type="text" name="address" ReadOnly title="??????" 
		placeholder="??????????????? ????????? ????????? 15-4" value="<%=address %>"><br />
		<span class="sp1">&nbsp;</span>
		<input type="text" name="addressDetail" title="????????????" 
		placeholder="ABC????????? 102??? 1102???" value="<%=addressDetail %>">
	</div>
	<div>
		<label for="basic_payment">??????????????????</label>
		<input type="text" name="basic_payment" id="basic_payment" title="??????????????????"
			placeholder="??????????????? ??????" value="<%=basic_payment%>">
	</div>
	<div>
		<label for="card_com">?????????</label>
		<select name="card_com" id="card_com" title="?????????" >
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
		<label for="card_num">????????????</label>
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
			<input type="submit" id="submit" value="?????? ??????" value="<%=m_vo.getUpload_name()%>">
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
			<h3>????????? ?????? ????????????</h3>
			
		</fieldset>
</div>
