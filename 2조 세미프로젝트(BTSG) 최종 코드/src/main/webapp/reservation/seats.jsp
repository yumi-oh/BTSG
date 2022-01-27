<%@page import="java.text.DecimalFormat"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.btsg.model.VOs.ConcertVO"%>
<%@page import="com.btsg.model.DAOs.ConcertDAO"%>
<%@page import="com.btsg.model.VOs.UserVO"%>
<%@page import="com.btsg.model.Services.UserService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../inc/top.jsp"%>   
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/reserv.css"/>

<%
   String user_id=(String)session.getAttribute("user_id");
   request.setCharacterEncoding("utf-8");
   String dateval = request.getParameter("dateval");
   String price = request.getParameter("price");
   UserService service = new UserService();
   UserVO vo =null;
   
   int basic_price = 0; 
   if(price!=null){
   	basic_price=Integer.parseInt(price);
	   
   }else{
	   basic_price=89000;
   }
   int vip_p=basic_price+60000;
   int r_p=basic_price+40000;
   int s_p=basic_price+20000;
   int a_p=basic_price;
   
   String concert_no = request.getParameter("concert_no");
   ConcertDAO dao = new ConcertDAO();
   ConcertVO concert_vo=null;
   String hp="";
   String hp1="", hp2="", hp3="";
   try{
      vo = service.selectByUser_id(user_id);
      concert_vo=dao.selectByNo(Integer.parseInt(concert_no));
      hp=vo.getHp();
      hp1=hp.substring(0, 3);
      hp2=hp.substring(3, 7);
      hp3=hp.substring(7);
      
      hp=hp1+" - "+hp2+" - "+hp3;
   }catch(SQLException e){
      e.printStackTrace();
   }
	DecimalFormat df = new DecimalFormat("#,###");
%>
<script type="text/javascript">
	$(function(){
		$('#re').click(function(){
			var seatT="";
			var qt=0;
			if($('#seat_type').val()==0||$('#seat_qty').val()==0){
				alert('좌석과 수량을 선택하세요.');
				$('#seat_type').focus();
				event.preventDefault();
			}
		
		});
		
		$('#seat_type').change(function(){
			var total=0;
			var seat_price=$('#seat_type').val();
			var qty = $('#seat_qty').val();
			total+=seat_price*qty;
			$('#totalPrice').val(total);
			var seatT=$('#seat_type option:selected').text();
			$('#seatType').val(seatT);
			$('#seatQty').val(qty);
		});
		
		$('#seat_qty').change(function(){
			var total=0;
			var seat_price=$('#seat_type').val();
			qty = $('#seat_qty').val();
			total+=seat_price*qty;
			$('#totalPrice').val(total);
			var seatT=$('#seat_type option:selected').text();
			$('#seatType').val(seatT);
			$('#seatQty').val(qty);
			
			
		});
		
	});
</script>

   <header>
		<!--nav-->
		<div id="step">
			<nav class="content">
				<ul>
					<li><a href="#"><span id="2">①가격 선택</span></a></li>
					<li><a href="#"><span id="1">➁티켓수령방법/결제</span></a></li>
					<li><a href="#"><span id="3">➂애매완료</span></a></li>
				</ul>
			</nav>
			<!--//nav-->
		</div>
	</header>
	<div id="c_status_info">
		<fieldset id="pay_input1">
		<legend class="pay_input">예매자 정보</legend>
			<div id="back">
				<input type="text" value="<%=vo.getUser_name()%>" Readonly/>
				<input type="text" value="<%=hp%>" Readonly />
				<input type="text" value="<%=vo.getEmail() %>" Readonly />
			</div>
		</fieldset>
	</div>
	<div id="seat_pic">
		<p>공연장 배치 안내</p> 
		<img src="<%=request.getContextPath() %>/assets/img/concertHall.png" width="900" height="500" alt="bts" src="">
	</div>
	<form id = "seat_c" method="post" name="seat_c" action="<%=request.getContextPath() %>/reservation/reservation.jsp">
		<input type="hidden" name="concert_no" value="<%=concert_no%>">
		<input type="hidden" id= "seatType" name="seatType" value="">
		<input type="hidden" id= "seatQty" name="seatQty" value="">
		<input type="hidden" id= "dateval" name="dateval" value="<%=dateval%>">
		<div class="p_title_area">
			<div class="concert">
				<span id="con_name"><%=concert_vo.getConcert_name() %></span>
			</div>
		<br><br>
		<div>
			<img src="<%=concert_vo.getUpload_name() %>" width="210" height="270" alt="bts" />
		</div>           
		<br><br>   
	                 
	
		<p><span id="con_pl">부산사직실내체육관</span></p>
		<p id="selected_date"><%=dateval %></p>                                    
		<br>                                       
	
		
	 
		<br><br>
		<div class="total-wrap">
			<span id="gun">총</span>
			<input type="text" name ="totalPrice" id="totalPrice"  Readonly value="">원
			</div>
		</div>
		       
		<div id="rese_div">
			<input type="submit" id="re" value="결제/수령방법선택"><br>
		</div>
	</form>
	<div id="c_seat_info">
			<fieldset id="seat_choice">
			<legend class="seat">관람석 선택</legend>
			<div>
				<div id="payment">
					<select name="seat_type" id="seat_type">
						<option value=0>좌석을 선택하세요.</option>
						<option value=<%=vip_p %>>VIP석 1인관람(<%=df.format(vip_p) %>)</option>
						<option value=<%=r_p %>>R석 1인관람권(<%=df.format(r_p) %>)</option>
						<option value=<%=s_p %>>S석 1인관람권(<%=df.format(s_p) %>)</option>
						<option value=<%=a_p %>>A석 1인관람권(<%=df.format(a_p) %>)</option>
					</select>
				</div>
				<div id="qty">
					<select name="seat_qty" id="seat_qty">
	                      <option label="0" value=0>수량을 선택하세요.</option>
	                      <option label="1" value=1>1</option>
	                      <option label="2" value=2>2</option>
	                      <option label="3" value=3>3</option>
	                      <option label="4" value=4>4</option>
	                      <option label="5" value=5>5</option>
	            	</select>
            	</div>
            </div>
			</fieldset>
	</div>
	

<%@ include file="../inc/bottom.jsp"%>