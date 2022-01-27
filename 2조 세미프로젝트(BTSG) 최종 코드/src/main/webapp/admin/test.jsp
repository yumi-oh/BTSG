<%@page import="com.btsg.model.Services.UserService"%>
<%@page import="com.btsg.model.VOs.UserVO"%>
<%@page import="com.btsg.model.VOs.ConcertVO"%>
<%@page import="com.btsg.common.Utility"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.btsg.model.VOs.ReviewVO"%>
<%@page import="java.util.List"%>
<%@page import="com.btsg.model.DAOs.ConcertDAO"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	


<%@ include file="../inc/top.jsp" %>
<jsp:useBean id="userVO" class="com.btsg.model.VOs.UserVO" scope="page"></jsp:useBean>
<jsp:useBean id="userService" class="com.btsg.model.Services.UserService" scope="session"></jsp:useBean>
<link rel="stylesheet" href="../css/jquery-ui.css">
<script type="text/javascript" src="../js/detail.js"></script>
  
  <script>
  $( function() {
    $( "#datepicker" ).datepicker();
  } );
  
  </script>
    
<%

	//goods_list.jsp => get
	
	request.setCharacterEncoding("utf-8");
	
	String concert_no=request.getParameter("concert_no");
	String review_no=request.getParameter("review_no");
	String user_id=(String)session.getAttribute("user_id");
	
	if(concert_no==null || concert_no.isEmpty()){ %>
		<script type="text/javascript">
			alert("잘못된 url입니다.");
			location.href="concertList.jsp";
		</script>
	<%	return;
	}
	//String condition=request.getParameter("searchCondition");
	//String keyword=request.getParameter("searchKeyword");

	ConcertDAO dao=new ConcertDAO();
	
	ReviewVO reviewVo=new ReviewVO();
	UserVO userVo=null;
	ConcertVO concertVo=null;
	List<ReviewVO> list=null;
	float avgRate=0;
	try{
		userVo=userService.selectByUser_id(user_id);
		concertVo=dao.selectByNo(Integer.parseInt(concert_no));
		list=dao.selectAllReview(Integer.parseInt(concert_no));
		avgRate=dao.getAvgRate(Integer.parseInt(concert_no));
	}catch(SQLException e){
		e.printStackTrace();
	}
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	
	//페이징
	int currentPage=1;
	if(request.getParameter("currentPage")!=null){
		currentPage=Integer.parseInt(request.getParameter("currentPage"));
	}
	int totalRecord=list.size();
	int pageSize=5;
	int totalPage=(int)Math.ceil((float)totalRecord/pageSize);
	int blockSize=10;
	
	int firstPage=currentPage-((currentPage-1)%blockSize);
	int lastPage=firstPage+(blockSize-1);
	
	int curPos=(currentPage-1)*pageSize;
	int num=totalRecord-curPos; 
	
	//이미지 출력

%>
	
<!-- 상품 상세 정보 -->
<div class="detailArea">
	<div class="imglArea">
		<div class="detail-tab">
			<ul class="nav nav-tabs menu">
			  <li class="nav-item">
			    <a class="nav-link fcolor" aria-current="page" href="#">상세정보</a>
			  </li>
			  <li class="nav-item">
			    <a class="nav-link fcolor" href="#">공연안내</a>
			  </li>
			  <li class="nav-item">
			    <a class="nav-link fcolor">예매안내</a>
			  </li>
			  <li class="nav-item">
			    <a class="nav-link fcolor" href="#smartReview">관람후기<span><%=list.size() %></span></a>
			  </li>
			</ul>
		</div><!-- detail-tab -->
		<div class="detail-cont">
			<div id="prdInfo">
				<div id="conDetail" class="on">
					<div class="cont">
						<strong>공연시간</strong><br> 
						<div>
							<hr>
							평일 8시 / 토, 일, 공휴일 3시, 6시 30분 (월 공연 없음)<br>
							※ 아래 회차 공연은 판매 마감되었으며, 추후 별도 오픈 예정이니 예매에 참고하시기 바랍니다.<br>
							   12월 22일(수) 8시 / 12월 23일(목) 8시 / 12월 24일(금) 8시 / 1월 8일(토) 3시, 1월 8일(토) 6시 30분<br>
							<hr>
							※ 객석 A,C구역의 측면 일부 좌석은 무대 설치 관련하여 판매 보류 되었으며, 무대 설치 상황에 따라 추후 추가 판매될 수 있습니다.<br>
						</div>
					</div>
				</div><!-- conDetail -->

				<div id="conNotice">
					<div class="cont">
						<div id="map" style="width:600px;height:350px;"></div>
						<div>
							<p>콘서트장 위치 | 콘서트장 매개변수 받아오기</p>
						</div>
						<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a170505ab6b2d2ead70875dbd3eee20a&libraries=services"></script>
						<script>
							var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
							    mapOption = {
							        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
							        level: 3 // 지도의 확대 레벨
							    };  
							
							// 지도를 생성합니다    
							var map = new kakao.maps.Map(mapContainer, mapOption); 
							
							// 주소-좌표 변환 객체를 생성합니다
							var geocoder = new kakao.maps.services.Geocoder();
							
							// 주소로 좌표를 검색합니다
							geocoder.addressSearch('서울특별시 용산구 한강대로 42', function(result, status) {
							
							    // 정상적으로 검색이 완료됐으면 
							     if (status === kakao.maps.services.Status.OK) {
							
							        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
							
							        // 결과값으로 받은 위치를 마커로 표시합니다
							        var marker = new kakao.maps.Marker({
							            map: map,
							            position: coords
							        });
							
							        // 인포윈도우로 장소에 대한 설명을 표시합니다
							        var infowindow = new kakao.maps.InfoWindow({
							            content: '<div style="width:150px;text-align:center;padding:6px 0;">콘서트장 위치</div>'
							        });
							        infowindow.open(map, marker);
							
							        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
							        map.setCenter(coords);
							    } 
							});    
						</script>
					</div><!-- cont -->
				</div><!-- conNotice -->
				<div id="buyNotice">
					<div class="cont">
						<strong>티켓 수령안내</strong>
						<hr>
						<strong>현장수령</strong><br> 
							- 관람일 당일 예매내역 또는 예매자의 신분증을 제시 후 티켓을 수령하여 입장합니다.<br>
							- 상품별로 티켓수령방법 및 입장 정책이 상이할 수 있습니다. 상품 상세정보를 확인해주시기 바랍니다.<br>
						<br>
						<strong>배송</strong><br> 
						<div>
							- 예매완료(결제완료/입금완료 익일) 기준 4~5일 이내에 주소로 배송됩니다. (주말/공휴일 제외한 영업일 기준)<br>
							- 일괄배송 티켓의 경우 상품별로 정해진 일괄배송일로부터 순차적으로 발송이 시작됩니다.<br>
							- 배송 중 전달 불가사항이 발생할 시에는 반송되며, 본인 수령 불가 시 경우에 따라 대리 수령도 가능합니다.<br>
							- 반송된 티켓은 현장수령 티켓으로 변경되어 관람일 당일 현장에서 수령하실 수 있습니다.<br>
							- 반송이 확인되지 않은 티켓은 현장에서도 수령하실 수 없으며, 공연 관람 및 환불이 불가합니다.<br>
							- 관람 3일전까지 티켓을 배송 받지 못하신 경우 위메프 고객센터(1661-4764)로 연락 주시기 바랍니다.<br>
							- 배송티켓 수령 후, 도난 및 분실/훼손이 발생한 경우 재발권이 되지 않습니다.<br>
						</div>
						<strong>모바일티켓</strong><br> 
						<div>
							- 모바일티켓은 위메프 앱이 설치된 휴대폰에서만 사용할 수 있습니다.<br>
							- 관람일 당일 위메프 앱의 ‘마이페이지>공연티켓 예매확인/취소‘ 메뉴에서 모바일티켓을 제시, 확인 후 입장하실 수 있습니다.<br>
							- 모바일 티켓은 상품별로 입장 정책이 상이할 수 있습니다. 상품 상세정보를 확인해주시기 바랍니다.<br>
						</div>
					</div>
				</div><!-- buyNotice -->
			</div><!-- prdInfo -->
		</div><!-- detail-cont -->
		<div id="conLanding">
			<div class="cont">
				<strong>공지사항</strong>
				<hr>
				<p>
					<img alt=""
						src="../assets/img/concert_notice.jpg"><!-- 서버에 저장된 이미지 출력 -->
				</p>
				<p>&nbsp;</p>
			</div>
		</div><!-- conDetail -->
	</div><!-- imglArea -->
</div><!-- detailArea -->
		
<div id="infoArea">
	<div id="info">
		<h3>BTS WORLD TOUR | SPEAK YOURSELF</h3>
		<div id="datepicker"></div>
		<p>
			PRICE |  <span>49,500원</span>
		</p>
		<table border="0" >
			<caption>상품목록</caption>
			<colgroup>
				<col style="width: 284px;" />
				<col style="width: 80px;" />
				<col style="width: 110px;" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">상품명</th>
					<th scope="col">상품수</th>
					<th scope="col">가격</th>
				</tr>
			</thead>
			<tbody class="">
				<tr>
					<td>BLACKPINK IN YOUR AREA MONOPOLY</td>
					<td><span class="quantity"> <input id="quantity"
							name="quantity_opt[]" style="" value="1" type="text" />
							<a href="javascript:;" class="up QuantityUp"><img
								src="../assets/img/btn_count_up.gif"
								alt="수량증가" /></a> <a href="javascript:;"
							class="down QuantityDown"><img
								src="../assets/img/btn_count_down.gif"
								alt="수량감소" /></a>
					</span></td>
					<td class="right"><span class="quantity_price">55000</span></td>
				</tr>
			</tbody>
		</table>
	</div><!-- info -->
	<div id="btn_box">
		<div class="btn_wrap">
			<button type="button" class="btn btn-dark">SHOPPING BAG</button>
			<a href= "<%=request.getContextPath()%>/reservation/reservation.jsp"><button type="button" class="btn btn-dark">BUY</button></a>
		</div><!-- btn_wrap -->
	</div><!-- btn_box -->
</div><!-- infoArea -->

<div id="smartReview">
	<div class="reviewArea">
		<div class="reviewGrade">
			<div class="status">
			<script type="text/javascript">
				$(function(){
					$('#starimg').css('width','<%=avgRate*20%>%');
				})
			</script>
				<div id="starwrap">
					<p><%=avgRate %></p>
					<div id="star"></div>
					<div id="starimg"></div>
					<span><%=list.size() %>개 리뷰 평점</span>
				</div>
			</div>
			<div class="thumbList">
					
				<ul>
					<%for(int i=0;i<list.size();i++){ 
						ReviewVO vo=list.get(i);
						if(vo.getOriginal_name()!=null){
					%>
					<li><img src="../uploadFile/<%=vo.getOriginal_name()%>"></li>
					<%} 
					}%>
				</ul>
			</div>
		</div>
		<div class="reviewList">

			<div class="divList">
				<table class="">
					<colgroup>
						<col style="width:20%;" />
						<col style="width:75%;" />
					</colgroup>
					<tbody>  
						<%if(list.size()==0){ %>
							<tr>
								<td colspan="2">작성된 리뷰가 없습니다.</td>
							</tr>
						<%} %>
					  <!--게시판 내용 반복문 시작  -->	
					  <%
					  for(int i=0;i<pageSize ;i++){
					    	if(num<1) break;	
					    
							ReviewVO vo=list.get(curPos++);
							num--;
					  %>
						  <tr  style="text-align:center">
							<td>
								<div class="user_rate">
								<%for(int j=0;j<vo.getRate();j++){ %>
										<img src="../assets/img/ico_star_rating_on.png">
								<% }%>
								<%if(vo.getRate()<5){
										 for(int r=0;r<5-vo.getRate();r++){%>
											<img src="../assets/img/ico_star_rating.png">
								<%	}
								 }%>
								</div>
							</td>
							<td style="text-align:left">
								 <%if(vo.getDelflag().equals("Y")){ %>
									<span style="color:gray">삭제된 글입니다.</span>
								<%}else{ %> 
									
									<!-- 파일이 첨부된 경우 파일이미지 보여주기 -->
									<%=Utility.displayFile(vo.getUpload_name()) %>
									
									<!-- 제목이 긴 경우 일부만 보여주기 -->
									<strong><%=Utility.cutString(vo.getContent(), 35) %></strong>
									
									<!-- 24시간 이내의 글인 경우 new 이미지 보여주기 -->
									<%=Utility.displayNew(vo.getRegdate()) %>
							 	<%} %>	
							 	<br><br>
							 	<a id="moreview">[더보기]</a> 
							 	<div id="review_con">
							 		<img src="../uploadFile/<%=vo.getOriginal_name()%>" />
							 		<p><%=vo.getContent() %></p> 
							 	</div>
								<p><%=sdf.format(vo.getRegdate()) %></p>
							</td>
						</tr>
					<%}//for %>
			  <!--반복처리 끝  -->
			  </tbody> 
			  </table>
			</div>
			<div class="divPage">
			   <!-- 페이지 번호 추가 -->      
			   <!-- 이전 블럭으로 이동 -->
			   <%
			   		if(firstPage>1){%>
			   			<a href="goods_detail.jsp?currentPage=<%=firstPage-1%>">
			   				<img src="../images/first.JPG" alt="이전블럭">
			   			</a>	
			   <% }%>              
			   <!-- [1][2][3][4][5][6][7][8][9][10] -->
			   <%
			   		for(int i=firstPage;i<=lastPage;i++){
			   			if(i>totalPage)	break;
			   			if(i==currentPage){%> 
							<span style="font-weight:bold;font-size:1em">[<%=i %>]</span>   			
			   			<%}else{%>
				   			<a href="goods_detail.jsp?currentPage=<%=i %>">[<%=i %>]</a>
			   			<%} %>
			   <% }%>
			   <!-- 다음 블럭으로 이동 -->
			   <%if(lastPage<totalPage){%>
			   			<a href="goods_detail.jsp?currentPage=<%=lastPage+1%>">
			   				<img src="../images/last.JPG" alt="다음블럭">
			   			</a>	
			   <% }%>              
			   <!--  페이지 번호 끝 -->
			</div>
			<div class="divSearch">
				<button type="button" id="btn_review" class="btn btn-light">리뷰 작성</button>
			</div>
		</div>
	<div id="writeReview">
		<form name="reviewWrite" method="post" action="concert_detail_review_ok.jsp"
			encType="multipart/form-data">
			<input type="text" name="user_no" value="<%=userVo.getUser_no()%>">
			<input type="text" name="concert_no" value="<%=concert_no%>">
			
			<div>
				<h3>후기 작성하기</h3>
				<label for="rate" class="label">공연은 어떠셨나요?</label>
				<div class="chk_list">
				    <input type="radio" name="rate" value="5" id="rate1"><label for="rate1"></label>
				    <input type="radio" name="rate" value="4" id="rate2"><label for="rate2"></label>
				    <input type="radio" name="rate" value="3" id="rate3"><label for="rate3"></label>
				    <input type="radio" name="rate" value="2" id="rate4"><label for="rate4"></label>
				    <input type="radio" name="rate" value="1" id="rate5"><label for="rate5"></label>
				</div>
			</div>
			<div class="mb-3">
			  <label for="exampleFormControlTextarea1" class="form-label">후기를 작성해주세요.</label>
			  <textarea class="form-control" id="exampleFormControlTextarea1 content" name="content" rows="3"></textarea>
			</div>
			<div class="mb-3">
			  <label for="formFile" class="form-label">이미지 업로드</label>
			  <input class="form-control" type="file" id="formFile" name="upfile" >
			</div>
			<button type="button" id="btn_cancel" class="btn btn-light">취소</button>
			<button id="btn_review" class="btn btn-dark">리뷰 작성</button>
		</form>
	</div>
</div>

<%@ include file="../inc/bottom.jsp" %>