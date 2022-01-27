<%@page import="java.text.DecimalFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.btsg.model.VOs.ConcertVO"%>
<%@page import="com.btsg.model.VOs.UserVO"%>
<%@page import="com.btsg.model.DAOs.ConcertDAO"%>
<%@page import="com.btsg.model.DAOs.PurchaseDAO"%>
<%@page import="com.btsg.model.DAOs.UserDAO"%>
<%@page import="com.btsg.model.VOs.PurchaseVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../inc/top.jsp"%>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/reserv.css"/>
<%
	String user_id = (String)session.getAttribute("user_id");
	String purchase_no = request.getParameter("purchase_no");
	
	
	   
	UserDAO userDao = new UserDAO();
	PurchaseDAO purchaseDao = new PurchaseDAO();
	ConcertDAO concertDao = new ConcertDAO();
	
	UserVO userVo=null;
	PurchaseVO purchaseVo=null;
	ConcertVO concertVo=null;
	String hp="", hp1="", hp2="";
	try{
	   userVo=userDao.selectByUser_id(user_id);
	   purchaseVo = purchaseDao.selectByPurchaseNo(Integer.parseInt(purchase_no));
	   concertVo=concertDao.selectByNo(purchaseVo.getConcert_no());
	   hp=userVo.getHp();
	   hp1=hp.substring(0, 3);
	   hp2=hp.substring(7);
	   hp=hp1+" - **** - "+hp2;
	}catch(SQLException e){
	   e.printStackTrace();      
	}
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	DecimalFormat df = new DecimalFormat("#,###");

%>
<div id="pur-detail">
	<p id="p">예매 상세내역</p>
	<div id="con_info">
		<div id="con_poster">
			<img src="<%=concertVo.getUpload_name()%>" width="210" height="270" alt="bts">
		</div>
		<div id="con-desc">
			<table>
					<tr style="text-align:left">
						<th scope="col" class="con">상품명</th>
						<td class="con"><%=concertVo.getConcert_name() %></td>
					</tr>
					<tr style="text-align:left">
						<th scope="col" class="con">관람일시</th>
						<td class="con"><%=purchaseVo.getCon_date()%></td>
					</tr>
					<tr style="text-align:left">
						<th scope="col" class="con">좌석정보</th>
						<td class="con"><%=purchaseVo.getSeatType() %></td>
					</tr>
					<tr style="text-align:left">
						<th scope="col" class="con">예매번호</th>
						<td class="con"><span id="bun">202112<%=purchaseVo.getPurchase_no()%>번</span></td>
					</tr>
					<tr style="text-align:left">
						<th scope="col" class="con">예매매수</th>
						<td class="con"><span id="mae"><%=purchaseVo.getSeatQty() %>매</span></td>
					</tr>
			</table>
		</div>
	</div>
	<div id="pur_info">
		<table id="pur_de">
		
				<tr style="text-align:left">
					<th scope="col" class="pur">예매자</th>
					<td class="pur"><%=userVo.getUser_name()%></td>
				</tr>
				<tr style="text-align:left">
					<th scope="col" class="pur">휴대폰번호</th>
					<td class="pur"><%=hp%></td>
				</tr>
				<tr style="text-align:left">
					<th scope="col" class="pur">예매일시</th>
					<td class="pur"><%=sdf.format(purchaseVo.getPaymentdate()) %></td>
				</tr>
				<tr style="text-align:left">
					<th scope="col" class="pur">결제수단</th>
					<td class="pur"><%=userVo.getCard_com()%>카드(<%=userVo.getBasic_payment() %>)</td>
				</tr>
				<tr style="text-align:left">
					<th scope="col" class="pur">결제금액</th>
					<td class="pur"><%=df.format(purchaseVo.getPrice()) %>원</td>
				</tr>
		</table>
	</div>
</div>
<%@ include file="../inc/bottom.jsp" %>