<%@page import="com.btsg.model.VOs.ConcertVO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.btsg.model.DAOs.ConcertDAO"%>
<%@page import="com.btsg.model.VOs.UserVO"%>
<%@page import="com.btsg.model.Services.UserService"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../inc/top.jsp"%>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/reserv.css"/>
</head>
<body>
<%
	request.setCharacterEncoding("utf-8");

	String user_id=(String)session.getAttribute("user_id");
	String concert_no=request.getParameter("concert_no");
	String dateval=request.getParameter("dateval");
	String totalPrice = request.getParameter("totalPrice");
	String qty = request.getParameter("seatQty");
	String seatType = request.getParameter("seatType");
	
	int seatQty=Integer.parseInt(qty);
	UserService service = new UserService();
	UserVO vo =null;
	
	ConcertDAO dao = new ConcertDAO();
	ConcertVO concert_vo=null;
	
	String card_num1="";
	String card_num2="";
	String card_num3="";
	String card_num4="";
	String zipcode="";
	String address="";
	String addressDetail="";
	String basic_payment="";
	String cardcom="";
	
	String hp="";
	String hp1="", hp2="", hp3="";
	try{
		vo = service.selectByUser_id(user_id);
		concert_vo=dao.selectByNo(Integer.parseInt(concert_no));
		String cardnum=vo.getCard_num();
		hp=vo.getHp();
	    hp1=hp.substring(0, 3);
	    hp2=hp.substring(3, 7);
	    hp3=hp.substring(7);
	      
	    hp=hp1+" - "+hp2+" - "+hp3;
		if(cardnum!=null && !cardnum.isEmpty()){
			card_num1=cardnum.substring(0, 4);
			card_num2=cardnum.substring(5, 9);
			card_num3=cardnum.substring(10, 14);
			card_num4=cardnum.substring(15, 19);
		}else{
			card_num1="";
			card_num2="";
			card_num3="";
			card_num4="";
		}
		basic_payment = vo.getBasic_payment();
		if(basic_payment==null){
			basic_payment="";
		}
		cardcom=vo.getCard_com();
		String non = "none";
		if(non.equals(cardcom)){
			cardcom="";
		}
		
		zipcode=vo.getZipcode();
		address=vo.getAddress();
		addressDetail=vo.getAddressDetail();
		
		if(vo.getZipcode()==null) zipcode="";
		if(vo.getAddress()==null) address="";
		if(vo.getAddressDetail()==null) addressDetail="";
		
		
	}catch(SQLException e){
		e.printStackTrace();
	}

%>
<script type="text/javascript">
	$(function(){
		$('input[name=way]').change(function(){
			$('div#deliver').toggleClass('hidden');
			$('#hed').toggleClass('hidden');
		});
		$('#con_date').change(function(){
			var con_date=$(this).val();
			$('#selected_date').text(con_date);
		});
		
		$('#payment input[type=radio]').change(function(){
			if($(this).val()==='b'){
				$('input[name=basic_payment]').val("<%=vo.getBasic_payment()%>");
				$('input[name=card_com]').val("<%=vo.getCard_com()%>");
				$('#n_card_num1').val("<%=card_num1%>");
				$('#n_card_num2').val("<%=card_num2%>");
				$('#n_card_num3').val("<%=card_num3%>");
				$('#n_card_num4').val("<%=card_num4%>");
			}else{
				$('input[name=basic_payment]').val("");
				$('#nick').text("결제수단 별칭");
				$('input[name=card_com]').val("");
				$('#n_card_num1').val("");
				$('#n_card_num2').val("");
				$('#n_card_num3').val("");
				$('#n_card_num4').val("");
			}
		});
		$('#deliver input[type=radio]').change(function(){
			if($(this).val()==='b'){
				$('input[name=zipcode]').val("<%=vo.getZipcode() %>");
				$('input[name=address]').val("<%=vo.getAddress() %>");
				$('input[name=addressDetail]').val("<%=vo.getAddressDetail() %>");
				
			}else{
				$('input[name=zipcode]').val("");
				$('input[name=address]').val("");
				$('input[name=addressDetail]').val("");
			}
		});
		
		$(function(){
			$('#btnZipcode').click(function(){
				open("../zipcode/zipcode.jsp", "zip", "width=500, height=500, left=30, top=30, resizable=yes, location=yes")
			});
		});
		$(function(){
			$('#go_main').click(function(){
				location.href="<%=request.getContextPath()%>/main/index.jsp";
			});
		});
		

		$('#payFrm').submit(function(){
			if ($('#pay_pwd').val().length<1){ 
				alert('결제비밀번호를 입력하세요');
				$('#pay_pwd').focus();
				event.preventDefault();
			}else if ($('#pay_pwd').val()!==$('#pwd').val()){ 
				alert('결제비밀번호가 일치하지 않습니다.');
				$('#pay_pwd').focus();
				event.preventDefault();
			}else if ($('#card_com').val().length<1){
				alert('결제정보 입력을 완료하세요');
				$('#card_com').focus();
				event.preventDefault();
			}else if ($('#card_num1').val().length!=4 ||
						$('#card_num2').val().length!=4 || $('#card_num3').val().length!=4 ||
						$('#card_num4').val().length!=4){
				alert('결제정보 입력을 완료하세요');
				$('#card_num1').focus();
				event.preventDefault();
			}else if (($('#zipcode').val().length<1 || $('#zipcode').val().length<1 ||
					$('#zipcode').val().length<1) && $('input[name=way]:checked').val()=='deliver'){
				alert('배송지 입력을 완료하세요');
				$('#addressDetail').focus();
				event.preventDefault();
			}
		});
		
	});
	</script>

	<header>
		<!--nav-->
		<div id="step">
			<nav class="content">
				<ul>
					<li><a href="#"><span id="1">①가격 선택</span></a></li>
					<li><a href="#"><span id="2">➁티켓수령방법/결제</span></a></li>
					<li><a href="#"><span id="3">➂애매완료</span></a></li>
				</ul>
			</nav>
			<!--//nav-->
		</div>
	</header>
	<form id = "payFrm" method="post" name="payFrm" action="reservation_ok.jsp">
		<div class="contents">
			<div>
				<div id="c_status_info">
					<fieldset id="pay_input1">
					 <legend class="pay_input">예매자 정보</legend>
					 <div id="back">
			       		 <input type="text" value="<%=vo.getUser_name()%>" Readonly/>
			       		 <input type="text" value="<%=hp %>" Readonly />
			       		 <input type="text" value="<%=vo.getEmail() %>" Readonly />
		       		 </div>
	       			</fieldset>
	     		</div>
	       		<div id="ticket_way">
					<fieldset id="pay_input2">
					<legend class="pay_input">수령방법 선택</legend>
						<div id="back">
							<input type="radio" class="form-check-input" id="deliv" checked="checked" name="way" style="front-size: 20px;" value="deliver">배송</input>
							<input type="radio" class="form-check-input" id="gamsung" name="way" style="front-size: 20px;" value="real">현장수령</input>
	       				</div>
	       			</fieldset>
	       		</div>
	       		
	       		<div id="c_payment_info">
	       			
	       				<fieldset id="pay_input3">
	       				<legend class="pay_input">결제정보</legend>
							<div id="payment">
							<input type="hidden" id="pwd" name="user_password" value="<%=vo.getUser_password()%>">
							<input type="hidden" name="concert_no" value="<%=concert_no%>">
							<input type="hidden" id= "seatType" name="seatType" value="<%=seatType%>">
							<input type="hidden" id= "seatQty" name="seatQty" value="<%=seatQty%>">
							<input type="hidden" name="totalPrice" value="<%=totalPrice%>">
							<input type="hidden" name="con_date" value="<%=dateval%>">
								<label><input type="radio" name="payment" id="basic_pay" value="b" style="front-size: 20px;" checked="checked">기본결제수단</label>
								<label><input type="radio" name="payment" id="new_pay" value="n" style="front-size: 20px;">새로운 결제수단</label><br>
								<label for="basic_payment" id="nick">기본 결제수단 별칭</label>
								<input type="text" class="pay" name="basic_payment" value="<%=basic_payment %>"><br>
								<label for="card_com">카드사</label>
								<input type="text" class="pay" id ="card_com" name="card_com" value="<%=cardcom %>"><br>
								<label for="card_num">카드번호</label>
						        <input type="text" class="pay" name="card_num" id="n_card_num1" value="<%=card_num1 %>" maxlength="4" >&nbsp;-&nbsp;
						        <input type="text" class="pay" name="card_num2" id="n_card_num2" value="<%=card_num2 %>" maxlength="4">&nbsp;-&nbsp;
						        <input type="text" class="pay" name="card_num3" id="n_card_num3" value="<%=card_num3 %>"maxlength="4">&nbsp;-&nbsp;
						        <input type="password" class="pay" name="card_num4" id="n_card_num4" value="<%=card_num4 %>" maxlength="4"><br>
								<label for="card_num">결제비밀번호</label>
								<input type="password" name="card_pwd" id="pay_pwd">
							</div>
							<legend id='hed' class="pay_input">배송지 입력</legend>
							<div id="deliver">
								<label><input type="radio" name="addr" value="b" id="basic_ad" style="front-size: 20px;" checked="checked">기본배송지</label>
								<label><input type="radio" name="addr" value="n" id="new_ad" style="front-size: 20px;">새로운 배송지</label><br>
								<label for="zipcode"><span id="d_type">우편번호</span></label>
								<input type="text" class="del" id ="zipcode" name="zipcode" Readonly value="<%=zipcode%>"> <input type="button" class="btn btn-primary btn-sm" value="우편번호 찾기" id="btnZipcode" title="새창열림"><br>
								<label for="address">주소</label>
								<input type="text" class="del" name="address" value="<%=address%>"><br>
								<label for="">상세주소</label>
								<input type="text" class="del" name="addressDetail" value="<%=addressDetail%>"><br>
							</div>
	       				</fieldset>
	       			 
				</div>	
			</div>
			
          </div>
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
                 <input type="text" id="totalPrice"  Readonly value="<%=totalPrice %>">원
                </div>
            </div>
             
            <div id="reserv_div">
		         <input type="submit" id="reserv" value="예매하기">
		         <input type="button" id="go_main" value="메인홈페이지로">
		    </div>
		</form>
<%@ include file="../inc/bottom.jsp"%>