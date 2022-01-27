<%@page import="com.btsg.model.DAOs.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../inc/top.jsp" %>

<%
	String user_id = request.getParameter("user_id");
%>

<script type="text/javascript">
var InputImage = 
 (function loadImageFile() {
    if (window.FileReader) {
        var ImagePre; 
        var ImgReader = new window.FileReader();
        var fileType = /^(?:image\/bmp|image\/gif|image\/jpeg|image\/png|image\/x\-xwindowdump|image\/x\-portable\-bitmap)$/i; 
 
        ImgReader.onload = function (Event) {
            if (!ImagePre) {
            	  var newPreview = document.getElementById("imagePreview");
	              var older = document.getElementById("older");
	              ImagePre = new Image();
	              ImagePre.style.width = "421px";
	              ImagePre.style.height = "596px";
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
<script type="text/javascript">
	$(function(){
		$('#btnZipcode').click(function(){
			open("../zipcode/zipcode.jsp", "zip", "width=500, height=500, left=30, top=30, resizable=yes, location=yes")
		});
	});
</script>
<form id = "registerFrm2" method="post" name="register" action="additional_ok.jsp" encType="multipart/form-data">
		<fieldset id="regi">
			<legend>부가정보 입력하기</legend>
			<div>        
		       <label for="upload_name">프로필사진</label>
				<input name ="upload_name" id="image" type="file" onchange="InputImage();">
		    </div>
		    <div id="zip">
		        <label for="zipcode">주소</label>
		        <input type="text" name="zipcode" id="zipcode" ReadOnly  
		        	title="우편번호" placeholder="우편번호를 검색하세요.">
		        <input type="button" value="우편번호 찾기" id="btnZipcode" title="새창열림"><br />
		        <span class="sp1">&nbsp;</span>
		        <input type="text" name="address" ReadOnly title="주소" placeholder="서울특별시 은평구 신사동 15-4"><br />
		        <span class="sp1">&nbsp;</span>
		        <input type="text" name="addressDetail" title="상세주소" placeholder="ABC아파트 102동 1102호">
		    </div>
		    <div>
		       <label for="basic_payment">기본결제별칭</label>
		        <input type="text" name="basic_payment" id="basic_payment" title="기본결제수단"
		        	placeholder="카카오뱅크 체크">
		    </div>
		    <div>
		        <label for="card_com">카드사</label>
		        <select name="card_com" id="card_com" title="카드사">
		            <option value="none">카드사</option>
		            <option value="BC">BC</option>
		            <option value="master">master</option>
		            <option value="unionPay">union pay</option>
		        </select>
		       
		    </div>
		    <div>        
		       <label for="card_num">카드번호</label>
		       <input type="text" name="card_num1" id="card_num1" maxlength="4" placeholder="1234">&nbsp;-&nbsp;
		       <input type="text" name="card_num2" id="card_num2" maxlength="4" placeholder="5678">&nbsp;-&nbsp;
		       <input type="text" name="card_num3" id="card_num3" maxlength="4" placeholder="9101">&nbsp;-&nbsp;
		       <input type="password" name="card_num4" id="card_num4" maxlength="4" placeholder="0000">
		    </div>
		   </fieldset>
		   <fieldset id="regi_pro">
			<div id="imagePreview">
					<img src="<%=request.getContextPath() %>/assets/img/default_profile.jpg" width="421" height="596" id="older">
			</div><br>
			<h3>프로필 사진 미리보기</h3>
			<div class="regi_addi">
		         <input type="submit" id="submit" value="부가정보입력 & 회원가입완료">
		    </div>
		    <input type="hidden" name="user_id" value="<%=user_id%>">
			</fieldset>
	</form>
	
	

<%@ include file="../inc/bottom.jsp" %>