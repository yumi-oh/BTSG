<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ include file="../admin/top.jsp" %>

  
<!DOCTYPE html>
<html>
<script src="https://cdn.ckeditor.com/ckeditor5/30.0.0/classic/ckeditor.js"></script>
<style>
	.ck.ck-editor {
    	max-width: 700px;
	}
	.ck-editor__editable {
	    min-height: 400px;
	}
	
	#header{
	font-size:xx-large;
	
	}
	</style>

<link rel="stylesheet" type="text/css" href="../css/mainstyle.css" />
<link rel="stylesheet" type="text/css" href="../css/clear.css" />
<link rel="stylesheet" type="text/css" href="../css/formLayout.css" />
<link rel="stylesheet" type="text/css" href="../css/mystyle.css" />
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<header><h1 id="header" style="margin: 0 auto;">공연 등록 페이지</h1></header>
<div id="container" style="  display: flex;">
<div class="divForm">
<form name="frmWrite" method="post" action="concertUpload_ok.jsp"
enctype="multipart/form-data">
 <fieldset>
	<legend></legend>
        <div class="firstDiv">
            <label for="title">공연 제목</label>
            <input type="text" id="concert_name" name="concert_name" class="infobox" 
            	value="" />
        </div>
     	<div >
            <label for="title">콘서트홀 주소</label>
            <input type="text" id="hall_address" name="hall_address" class="infobox" />
        </div>
     
     
        <div >
            <label for="title">공연 시작일</label>
            <input type="date" id="start_date" name="start_date" class="infobox" 
            	value="" />
        </div>
 
        <div >
            <label for="title">공연 종료일</label>
            <input type="date" id="end_date" name="end_date" class="infobox" 
            	value="" />
        </div>
        
        <div >
            <label for="title">콘서트 가격</label>
            <input type="text" id="price" name="price" class="infobox" />
        </div>
      
  	     <textarea rows="5" cols="10" id="description" name="description">
        <p>본문 내용 입력</p>
    	</textarea>
    
        <script>
        ClassicEditor
            .create( document.querySelector( '#description' ))
            .catch( error => {
                console.error( error );
            } );
    </script>
        
        
        
        <div>
            <label for="upfile">썸네일 </label>
            <input type="file" id="upfile" name="upfile" />
            <span>(최대 10M)</span>
        </div>
        <div class="center">
            <input type = "submit" value="등록"/>
            <input type = "Button" id="btList" value="글목록" />         
        </div>
    </fieldset>
</form>

<script type="text/javascript" src="../js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	$(function(){
		$('form[name=frmWrite]').submit(function(){
			$('.infobox').each(function(idx, item){
				if($(this).val().length<1){
					alert($(this).prev().html() + "을(를) 입력하세요");
					$(this).focus();
					event.preventDefault();
					return false;  //each 탈출
				}
			});
		});
		
		$('#btList').click(function(){
			location.href='list.jsp';	
		});
		
	});
</script>
</div>
</div>   
</body>
</html>

<%@ include file="../inc/bottom.jsp" %>