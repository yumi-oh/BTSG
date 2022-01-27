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
<meta charset="UTF-8">
<title>BTSG-관리자 모드</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" 
rel="stylesheet" 
integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" 
crossorigin="anonymous">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/styles.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/mainstyle.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/layout.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/clear.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/detail.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/regi.css"/>

<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/goods_detail.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/login.js"></script>
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>

</head>
<body>
<div class="container">
<!-- Navigation-->
        <nav class="navbar navbar-expand-lg navbar-light fixed-top shadow-sm" id="mainNav">
            <div class="container px-5 py-3">
                <a class="navbar-brand fw-bold" href="<%=request.getContextPath() %>/main/index.jsp">BTS Ticket&Goods</span></a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
                    Menu
                    <i class="bi-list"></i>
                </button>
                <div class="collapse navbar-collapse" id="navbarResponsive">
                    <ul class="navbar-nav ms-auto me-4 my-3 my-lg-0">
                        <li class="nav-item"><a class="nav-link me-lg-3" href="<%=request.getContextPath() %>/admin/concertUpload.jsp">콘서트 등록</a></li>
                        <li class="nav-item"><a class="nav-link me-lg-3" href="<%=request.getContextPath() %>/concert/concertList.jsp">콘서트 목록</a></li>
                        <li class="nav-item"><a class="nav-link me-lg-3" href="<%=request.getContextPath()%>/admin/admin_user_list.jsp">회원 조회</a></li>
                    </ul>
                    <%if(t_isLogin) {%>
                    	<a href="<%=request.getContextPath()%>/login/logout.jsp">
	                    	<button id="logout"class="btn btn-main rounded-pill px-3 mb-2 mb-lg-0" data-bs-toggle="modal" data-bs-target="#feedbackModal">
		                            Logout
		                    </button>
	                    </a>
	                    
		                <a href="<%=request.getContextPath()%>/mypage/mypage.jsp">
		                    <button id="mypage"class="btn btn-main rounded-pill px-3 mb-2 mb-lg-0" data-bs-toggle="modal" data-bs-target="#feedbackModal">
		                            마이페이지
		                    </button>
		                 </a>
                    <%}else{ %>
                    	<a href="<%=request.getContextPath()%>/login/logout.jsp">
		                    <button id="go-log"class="btn btn-main rounded-pill px-3 mb-2 mb-lg-0" data-bs-toggle="modal" data-bs-target="#feedbackModal">
		                            login / Join
		                    </button>
	                   	</a>
                    <%} %>
                </div>
            </div>
        </nav>

		
		<!-- container -->
		<div class="masthead">
			<section id="contents">
