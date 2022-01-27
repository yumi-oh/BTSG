<%@page import="com.btsg.model.DAOs.ConcertDAO"%>
<%@page import="com.btsg.model.VOs.ConcertVO"%>
<%@page import="com.btsg.common.Utility"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.SQLException"%>
<%@page import="com.btsg.model.VOs.UserVO"%>
<%@page import="com.btsg.model.VOs.PurchaseVO"%>
<%@page import="java.util.List"%>
<%@page import="com.btsg.model.DAOs.UserDAO"%>
<%@page import="com.btsg.model.DAOs.PurchaseDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   request.setCharacterEncoding("utf-8");
   String l_user_id=(String)session.getAttribute("user_id");
   
   
      
   UserDAO userDao = new UserDAO();
   PurchaseDAO purchaseDao = new PurchaseDAO();
   ConcertDAO concertDao = new ConcertDAO();
   
   UserVO userVo=null;
   List<PurchaseVO> l_list=null;
   ConcertVO concertVo=null;
   try{
      userVo=userDao.selectByUser_id(l_user_id);
      l_list = purchaseDao.selectByUserNo(userVo.getUser_no());
      
   }catch(SQLException e){
      e.printStackTrace();
   }
   
   SimpleDateFormat l_sdf = new SimpleDateFormat("yyyy-MM-dd");
 
   
   //페이징 처리
   int currentPage=1; 
   
   if(request.getParameter("currentPage")!=null){
      currentPage=Integer.parseInt(request.getParameter("currentPage"));
   }
   

   int totalRecord=l_list.size(); 
   int pageSize=5;
   int totalPage=(int)Math.ceil((float)totalRecord/pageSize);
   int blockSize=10;

   int firstPage=currentPage-((currentPage-1)%blockSize);
   int lastPage=firstPage + (blockSize-1); 
   
   int curPos=(currentPage-1)*pageSize;
   int num=totalRecord-curPos; 
%>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/reserv.css"/>
<div id="reservation_list">
	<div id="reserv_serach">
	</div>
	<div id="reserv_list">
		<table class="table table-hover">
			
			<colgroup>
				<col style="width:15%;" />
				<col style="width:45%;" />
				<col style="width:25%;" />
				<col style="width:15%;" />
			</colgroup>
			<thead>
				<tr style="text-align:left">
					<th scope="col">예매번호</th>
					<th scope="col">공연명</th>
					<th scope="col">좌석정보</th>
					<th scope="col">상세보기</th>
				</tr>
			</thead> 
			<tbody>  
				  <!--게시판 반복문-->   
				<%  
				for(int i=0;i<pageSize ;i++){
				   if(num<1) break;   
				
				  PurchaseVO p_vo=l_list.get(curPos++);
				  concertVo = concertDao.selectByNo(p_vo.getConcert_no());
				  num--;
				%>   
				<tr  style="text-align:left">
					<td><%=p_vo.getPurchase_no() %></td>
					<td>
							<%=Utility.cutString(concertVo.getConcert_name(), 15) %>
					</td>
					<td><span id="result"><%=p_vo.getSeatType() %></span></td>
					<td><div id="go_de">
						<a href="<%=request.getContextPath() %>/mypage/purchase_detail.jsp?purchase_no=<%=p_vo.getPurchase_no() %>">
						<input class="btn btn-primary" id="go_detail" type="button" value="상세보기"></a> 
					</div></td>
				</tr> 
			<%}//for %>
			</tbody>
		</table>      
	</div>
</div>
<div id="divpa">
   <!-- 페이징-->
   <%if(firstPage>1){ //이전 페이지 %>
		<a href="reservationList.jsp?currentPage=<%=firstPage-1%>=">
			<img src="../images/first.JPG" alt="이전블럭">
		</a>
  <%}%>      
                  
   <%
      for(int i=firstPage;i<=lastPage;i++){
         if(i>totalPage) break; 
         if(i==currentPage){%>
         <span style="color:blue; font-weight: bold; font-size:1em"><%=i %></span>
        	 
   	  <% }else{%>
         <a href="<%=request.getContextPath() %>/mypage/mypage.jsp?currentPage=<%=i%>">[<%=i %>]</a>   	      
       <%} %>  
   <%   }//for    %>
   <%if(lastPage<totalPage){ //다음 페이지 %>
		<a href="<%=request.getContextPath() %>/mypage/mypage.jsp?currentPage=<%=lastPage+1%>">
			<img src="../images/last.JPG" alt="다음블럭">
		</a>
	<%} %>
   <!--  페이징 끝 -->
   
</div>