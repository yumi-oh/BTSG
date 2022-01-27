<%@page import="com.btsg.model.VOs.UserVO"%>
<%@page import="com.btsg.model.DAOs.UserDAO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.btsg.model.DAOs.PurchaseDAO"%>
<%@page import="com.btsg.model.VOs.PurchaseVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
	request.setCharacterEncoding("utf-8");

	String user_id=(String)session.getAttribute("user_id");
	String concert_no = request.getParameter("concert_no");
	String seatType = request.getParameter("seatType");
	String seatQty = request.getParameter("seatQty");
	String totalPrice = request.getParameter("totalPrice");
	String con_date = request.getParameter("con_date");
	String basic_payment=request.getParameter("basic_payment");
	String card_com = request.getParameter("card_com");
	UserDAO userDao= new UserDAO();
	UserVO userVo = null;
	
	PurchaseVO purVo = new PurchaseVO();
	PurchaseDAO purchaseDao = new PurchaseDAO();
	
	
	purVo.setBasic_payment(basic_payment);
	purVo.setCon_date(con_date);
	purVo.setConcert_no(Integer.parseInt(concert_no));
	purVo.setPrice(Integer.parseInt(totalPrice));
	purVo.setSeatQty(Integer.parseInt(seatQty));
	purVo.setSeatType(seatType);
	try{
		userVo=userDao.selectByUser_id(user_id);
		purVo.setUser_no(userVo.getUser_no());
		int cnt = purchaseDao.insertPurchase(purVo);
		if(cnt>0){%>
		<script type="text/javascript">
			alert("구매가 완료되었습니다!");
			location.href="<%=request.getContextPath()%>/mypage/mypage.jsp?isResev=y";
		</script>
	<%}else{%>
		<script type="text/javascript">
			alert("구매에 실패하였습니다.");
			history.back();
		</script>
	<%}
	}catch(SQLException e){
		e.printStackTrace();
	}

%>
</body>
</html>