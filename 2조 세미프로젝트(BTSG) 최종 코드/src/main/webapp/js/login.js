
	$(function(){
		$("#go-log").click(function(){
			location.href="<%=request.getContextPath()%>/login/login.jsp%>";
		});
		$("#logout").click(function(){
			location.href="<%=request.getContextPath()%>/login/logout.jsp%>";
		});
		$("#reserv").click(function(){
			location.href="<%=request.getContextPath()%>/login/login.jsp%>";
		});
		$("#mypage").click(function(){
			location.href="<%=request.getContextPath()%>/login/userEdit.jsp%>";
		});
	});