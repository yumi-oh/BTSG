<%-- <%@page import="jdk.internal.misc.FileSystemOption"%> --%>
<%@page import="com.btsg.model.DAOs.UserDAO"%>
<%@page import="com.btsg.model.VOs.UserVO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="top.jsp" %>
<%
	request.setCharacterEncoding("UTF-8");
	String condition=request.getParameter("searchCondition");
	String keyword=request.getParameter("searchKeyword");

	UserDAO dao = new UserDAO();
	List<UserVO> list = null;
	
	try{
		list=dao.selectAll();
	}catch(SQLException e){
		e.printStackTrace();		
	}
	
	//3
	
	if(keyword==null) keyword="";
	
	//페이징 처리
	int currentPage=1;  //현재 페이지
	
	//list.jsp?currentPage=2
	if(request.getParameter("currentPage")!=null){
		currentPage=Integer.parseInt(request.getParameter("currentPage"));
	}
	
	//현재 페이지와 무관한 변수
	int totalRecord=list.size(); //총 레코드 개수, 17
	int pageSize=5;  //한 페이지에 보여줄 레코드 수
	int totalPage=(int)Math.ceil((float)totalRecord/pageSize); //총 페이지수
	int blockSize=10;  //한 블럭에 보여줄 페이지 수
	
	//현재 페이지를 이용해서 계산하는 변수
	int firstPage=currentPage-((currentPage-1)%blockSize); //1,11,21,...
	int lastPage=firstPage+ (blockSize-1);  //10,20,30,...
	
	//페이지당 ArrayList에서의 시작 index => 0,5,10,15...
	int curPos=(currentPage-1)*pageSize;
	
	//페이지당 글 리스트 시작번호
	int num=totalRecord-curPos; //17, 12, 7, 2
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>관리자페이지-전체회원목록조회(list)_페이징</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>One Page Wonder - Start Bootstrap Template</title>
<link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
<!-- Font Awesome icons (free version)-->
<script src="https://use.fontawesome.com/releases/v5.15.4/js/all.js"
	crossorigin="anonymous"></script>
<!-- Google fonts-->
<link
	href="https://fonts.googleapis.com/css?family=Catamaran:100,200,300,400,500,600,700,800,900"
	rel="stylesheet" />
<link
	href="https://fonts.googleapis.com/css?family=Lato:100,100i,300,300i,400,400i,700,700i,900,900i"
	rel="stylesheet" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="css/styles.css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="../css/mainstyle.css" />
<link rel="stylesheet" type="text/css" href="../css/clear.css" />
<link rel="stylesheet" type="text/css" href="../css/formLayout.css" />
<link rel="stylesheet" type="text/css" href="../css/mystyle.css" />
<link rel="stylesheet" type="text/css" href="../css/styles.css" />
<link rel="stylesheet" type="text/css" href="../css/mainstyle.css" />
<script type="text/javascript" src="../js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">	
	$(function(){
		$('.divList .box2 tbody tr').hover(function(){
			$(this).css('background','skyblue');
		}, function(){
			$(this).css('background','');
		});
	});
</script>
<style type="text/css">
	body{
		padding:5px;
		margin:5px;
	 }	
</style>	
</head>	
<body>
	<h4>전체 회원 목록 조회</h4>
	<%-- <%
	if(keyword!=null && !keyword.isEmpty()){ %>
		<p>검색어 : <%=keyword %>,  <%=list.size() %>건 검색되었습니다. </p>
<%	} %> --%>
	<hr>
	<div class="divlist">
		<table border="1" class="box" summary="관리자페이지에서 전체 회원에 대한 목록을 조회할 수 있습니다.">
			<colgroup>
				<col style="width: 5%;" />
				<col style="width: 5%;" />
				<col style="width: 6%;" />
				<col style="width: 6%;" />
				<col style="width: 6%;" />
				<col style="width: 8%;" />
				<col style="width: 6%;" />
				<col style="width: 6%;" />
				<col style="width: 6%;" />
				<col style="width: 6%;" />
				<col style="width: 6%;" />
				<col style="width: 5%;" />
				<col style="width: 5%;" />
				<col style="width: 8%;" />
				<col style="width: 6%;" />
				<col style="width: 5%;" />
			</colgroup>

			<thead>
				<tr>
					<th scope="col">회원번호</th>
					<th scope="col">이름</th>
					<th scope="col">아이디</th>
					<th scope="col">패스워드</th>
					<th scope="col">닉네임</th>
					<th scope="col">이메일</th>
					<th scope="col">생년월일</th>
					<th scope="col">연락처</th>
					<th scope="col">우편번호</th>
					<th scope="col">주소</th>
					<th scope="col">주소상세</th>
					<th scope="col">결제수단</th>
					<th scope="col">카드사</th>
					<th scope="col">카드번호</th>
					<th scope="col">가입일</th>
					<th scope="col">탈퇴여부</th>
				</tr>
			</thead>
		
			<tbody>
<!--게시판 내용 반복문 시작  -->	
	  <%
	    /*for(int i=0;i<list.size();i++){
			BoardVO vo=list.get(i);*/
			
	    for(int i=0;i<pageSize ;i++){
	    	if(num<1) break;	
	    
			UserVO vo=list.get(curPos++);
			num--;
	   %>
				<tr>
					<td><%=vo.getUser_no()%></td>
					<td><%=vo.getUser_name()%></td>
					<td><%=vo.getUser_id()%></td>
					<td><%=vo.getUser_password()%></td>
					<td><%=vo.getNickname()%></td>
					<td><%=vo.getEmail()%></td>
					<td><%=vo.getBirth()%></td>
					<td><%=vo.getHp()%></td>
					<td><%=vo.getZipcode()%></td>
					<td><%=vo.getAddress()%></td>
					<td><%=vo.getAddressDetail()%></td>
					<td><%=vo.getBasic_payment()%></td>
					<td><%=vo.getCard_com()%></td>
					<td><%=vo.getCard_num()%></td>
					<td><%=vo.getUser_regdate()%></td>
				</tr>
				<%
				}
				%>
				
			</tbody>
		</table>
	</div>
	
	<div class="divPage">
	<!-- 페이지 번호 추가 -->		
	<!-- 이전 블럭으로 이동 -->					
	<%	if(firstPage>1){ %>
			<a href
="admin_user_list.jsp?currentPage=<%=firstPage-1%>&searchCondition=<%=condition%>&searchKeyword=<%=keyword%>">
				<img src="../images/first.JPG" alt="이전블럭">
			</a>	
	<%	}	%>					
	<hr>					
	<!-- [1][2][3][4][5][6][7][8][9][10] -->
	<%
		for(int i=firstPage;i<=lastPage;i++){
			if(i>totalPage) break; 
			
			if(i==currentPage){ 	%>
				<span style="color:blue;font-weight: bold;font-size: 1em">
					<%=i %></span>
			<%}else{ %>
				<a href="admin_user_list.jsp?currentPage=<%=i%>&searchCondition=<%=condition%>&searchKeyword=<%=keyword%>">
					[<%=i %>]</a>			
			<%}//if %>
	<%	}//for 	%>
	
	<!-- 다음 블럭으로 이동 -->					
	<%	if(lastPage < totalPage){ %>
			<a href="admin_user_list.jsp?currentPage=<%=lastPage+1%>&searchCondition=<%=condition%>&searchKeyword=<%=keyword%>">
				<img src="../images/last.JPG" alt="다음블럭">
			</a>	
	<%	}	%>					
	<!--  페이지 번호 끝 -->	
</div>
<%-- <div class="divSearch">
   	<form name="frmSearch" method="post" action='admin_user_list.jsp'>
        <select name="searchCondition">
            <option value="user_no" 
            	<%if("user_no".equals(condition)){ %>
            		selected="selected"
            	<%} %>
            >회원번호</option>
            <option value="user_name" 
            	<%if("user_name".equals(condition)){ %>
            		selected="selected"
            	<%} %>
            >이름</option>
            <option value="user_id" 
            	<%if("user_id".equals(condition)){ %>
            		selected="selected"
            	<%} %>
            >아이디</option>
        </select>   
        <input type="text" name="searchKeyword" title="검색어 입력"
        	value="<%=keyword%>">   
		<input type="submit" value="검색">
    </form>
</div> --%>

</body>
</html>
<%@ include file="../inc/bottom.jsp" %>