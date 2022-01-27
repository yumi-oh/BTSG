<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String t_userid=(String)session.getAttribute("user_id");
	boolean t_isLogin=false;
	if(t_userid!=null && !t_userid.isEmpty()){
		t_isLogin=true; 
	}
%>
<!DOCTYPE html>
<html>
<head>
<title>BTSG - BTS Tickets&Goods</title>
<!-- Bootstrap cdn 설정 -->
<link rel="stylesheet" type="text/css" href="../css/clear.css" />
<link rel="stylesheet" type="text/css" href="../css/header.css" />
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript" src="../js/jquery-3.6.0.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script>    
    var nav = $('.nav'),
        lang = $('.lang');

    $(nav).find('.menu_area').hover(function(){
        $('.header').addClass('on');
        $('.nav_bg').addClass('on');
        $(this).find('>li').addClass('on');
    }, function(){
        $('.header').removeClass('on');
        $('.nav_bg').removeClass('on');
        $(this).find('>li').removeClass('on');
    });

    $(lang).hover(function(){
        $('.lang_bg').addClass('on');
    }, function(){
        $('.lang_bg').removeClass('on');
    });        
</script>
</head>
<body>
	<header class="header" id="header">
        <h1 class="logo">
            <a href="#none">
                <img src="../assets/img/BTSG_logo_w.png" alt="" class="on">
                <img src="../assets/img/BTSG_logo_w.png" alt="" class="off">                
            </a>
        </h1>
        <nav class="nav" id="nav">
            <div class="nav_bg"></div>
            <ul class="menu_area clear">
                <li>
                    <a href="<%=request.getContextPath()%>/concert/concertList.jsp">CONCERT</a>
                    <ul class="depth_02">
                        <li><a href="#none">공연목록</a></li>
                        <li><a href="#none">공연예약</a></li>
                        <li><a href="#none">서브메뉴3</a></li>
                    </ul>
                </li>
                <li>
                    <a href="<%=request.getContextPath()%>/artist/artist.jsp">ARTIST</a>
                    <ul class="depth_02">
                        <li><a href="#none">서브메뉴1</a></li>
                        <li><a href="#none">서브메뉴2</a></li>
                        <li><a href="#none">서브메뉴3</a></li>
                    </ul>
                </li>
                <li>
                    <a href="#none">GOODS</a>
                    <ul class="depth_02">
                        <li><a href="#none">서브메뉴1</a></li>
                        <li><a href="#none">서브메뉴2</a></li>
                        <li><a href="#none">서브메뉴3</a></li>
                    </ul>
                </li>
                 <li>
                 <%if(!t_isLogin){ %>
                    <a href="<%=request.getContextPath()%>/login/login.jsp">LOGIN/SIGNUP</a>
                   <%}else{ %>
                    <a href="<%=request.getContextPath()%>/mypage/mypage.jsp">MY PAGE</a>&nbsp;&nbsp;&nbsp;
                   
                    <%} %>
                    <ul class="depth_02">
                        <li><a href="#none">서브메뉴1</a></li>
                        <li><a href="#none">서브메뉴2</a></li>
                        <li><a href="#none">서브메뉴3</a></li>
                    </ul>
                </li>
                <% if(t_isLogin){%>
                <li>
                    <a href="<%=request.getContextPath()%>/login/logout.jsp">LOGOUT</a>
                    <ul class="depth_02">
                        <li><a href="#none">서브메뉴1</a></li>
                        <li><a href="#none">서브메뉴2</a></li>
                        <li><a href="#none">서브메뉴3</a></li>
                    </ul>
                </li>
                <%} %>                                              
            </ul>
            <aside class="lang">
                <div class="lang_bg"></div>
                <div class="lang_hover">
                    <span>KOR</span>                    
                    <ul class="lang_list">
                        <li><a href="#none">ENG</a></li>
                        <li><a href="#none">CHN</a></li>
                        <li><a href="#none">JPN</a></li>
                    </ul>
                </div>
            </aside>
        </nav>
    </header>
	<!-- carousel를 구성할 영역 설정 -->
	<div style="height: 975px;width: 1920px; "> 
		<!-- carousel를 사용하기 위해서는 class에 carousel와 slide 설정한다. -->
		<!-- carousel는 특이하게 id를 설정해야 한다.-->
		<div id="carousel-example-generic" class="carousel slide">
			<!-- carousel의 지시자 -->
			<!-- 지시자라고는 하는데 ol태그의 class에 carousel-indicators를 넣는다. -->
			<ol class="carousel-indicators">
				<!-- li는 이미지 개수만큼 추가하고 data-target은 carousel id를 가르킨다. -->
				<!-- data-slide-to는 순서대로 0부터 올라가고 0은 active를 설정한다. -->
				<!-- 딱히 이 부분은 옵션별로 설정하게 없다. -->
				<li data-target="#carousel-example-generic" data-slide-to="0"
					class="active"></li>
				<li data-target="#carousel-example-generic" data-slide-to="1"></li>
				<li data-target="#carousel-example-generic" data-slide-to="2"></li>
				<li data-target="#carousel-example-generic" data-slide-to="3"></li>
				<li data-target="#carousel-example-generic" data-slide-to="4"></li>
			</ol>
			<!-- 실제 이미지 아이템 -->
			<!-- class는 carousel-inner로 설정하고 role은 listbox에서 설정한다. -->
			<div class="carousel-inner" role="listbox">
				<!-- 이미지의 개수만큼 item을 만든다. 중요한 포인트는 carousel-indicators의 li 태그 개수와 item의 개수는 일치해야 한다. -->
				<div class="item active">
					<!-- 이미지 설정- -->
					<img
						src="img/2.png"
						style="height: 975px;width: 1920px; ">
					<!-- 캡션 설정 (생략 가능) -->
					<!-- 글자 색은 검은색 -->
					<div class="carousel-caption" style="color: black;">&nbsp;
					</div>
				</div>
				<div class="item">
					<img src="img/2.jpg"
						style="height: 975px;width: 1920px; ">
					<div class="carousel-caption" style="color: black;">&nbsp;
					</div>
				</div>
				<div class="item">
					<img src="img/main3.jpg"
						style="height: 975px;width: 1920px; ">
					<div class="carousel-caption" style="color: black;">&nbsp;
					</div>
				</div>
				
				<div class="item">
					<img src="img/main6.jpg"
						style="height: 975px;width: 1920px; ">
					<div class="carousel-caption" style="color: black;">&nbsp;
					</div>
				</div>
				<div class="carousel-caption">
				<a href="<%=request.getContextPath() %>/artist/profile_RM.jsp">
				<img src="img/rm.jpg"
						style="height: 100px;width: 80px; margin-left: 100px; border-radius: 20%">
				</a></div>
				<div class="carousel-caption">
				<a href="<%=request.getContextPath() %>/artist/profile_jimin.jsp">
				<img src="img/jimin.jpg"
						style="height: 100px;width: 80px; margin-left: 300px; border-radius: 20%">
            	</a></div>
				<div class="carousel-caption">
				<a href="<%=request.getContextPath() %>/artist/profile_JH.jsp">
				<img src="img/hope.jpg"
						style="height: 100px;width: 80px; margin-left: 500px; border-radius: 20%">
            	</a></div>
				<div class="carousel-caption">
				<a href="<%=request.getContextPath() %>/artist/profile_jin.jsp">
				<img src="img/jin.jpg"
						style="height: 100px;width: 80px; margin-left: 700px; border-radius: 20%">
            	</a></div>
				<div class="carousel-caption">
				<a href="<%=request.getContextPath() %>/artist/profile_SG.jsp">
				<img src="img/su.jpg"
						style="height: 100px;width: 80px; margin-left: 900px; border-radius: 20%">
            	</a></div>
				<div class="carousel-caption">
				<a href="<%=request.getContextPath() %>/artist/profile_V.jsp">
				<img src="img/v.jpg"
						style="height: 100px;width: 80px; margin-left: 1090px; border-radius: 20%">
            	</a></div>
				<div class="carousel-caption">
				  <a href="<%=request.getContextPath() %>/artist/profile_JK.jsp">
				<img src="img/jung.jpg"
						style="height: 100px;width: 80px; margin-left: 1190px; border-radius: 20%">
            	</a></div>
			<!-- 왼쪽 화살표 버튼 -->
			<!-- href는 carousel의 id를 가르킨다. -->
			<a class="left carousel-control" href="#carousel-example-generic"
				role="button" data-slide="prev"> <!-- 왼쪽 화살표 --> <span
				class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
			</a>
		</div>
	</div>
	<script>
		$(function() {
			// 이미지 슬라이드 컨트롤를 사용하기 위해서는 carousel를 실행해야한다.
			$('#carousel-example-generic').carousel({
				// 슬리아딩 자동 순환 지연 시간
				// false면 자동 순환하지 않는다.
				interval : 3000,
				// hover를 설정하면 마우스를 가져대면 자동 순환이 멈춘다.
				pause : "hover",
				// 순환 설정, true면 1 -> 2가면 다시 1로 돌아가서 반복
				wrap : true,
				// 키보드 이벤트 설정 여부(?)
				keyboard : true
			});
		});
	</script>
</body>
</html>