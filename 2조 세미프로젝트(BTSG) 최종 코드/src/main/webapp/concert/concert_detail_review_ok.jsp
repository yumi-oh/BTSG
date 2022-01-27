<%@page import="com.btsg.model.DAOs.ConcertDAO"%>
<%@page import="com.btsg.model.VOs.ReviewVO"%>
<%@page import="com.btsg.model.VOs.UserVO"%>
<%@page import="com.btsg.common.Utility"%>
<%@page import="java.io.IOException"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<jsp:useBean id="userVO" class="com.btsg.model.VOs.UserVO" scope="page"></jsp:useBean>
<jsp:useBean id="reviewVo" class="com.btsg.model.VOs.ReviewVO" scope="page"></jsp:useBean>
<jsp:useBean id="userService" class="com.btsg.model.Services.UserService" scope="session"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
</head>
<body>
<%
	//goods_detail=>post
	//1
	//request.setCharacterEncoding("utf-8");
	
	//실제 물리적인 경로(절대경로)
	String saveDir=application.getRealPath(Utility.UPLOAD_PATH);//업로드 경로
	saveDir=config.getServletContext().getRealPath(Utility.UPLOAD_PATH);
	System.out.print(saveDir);
	saveDir="C:\\Users\\USER\\git\\BTSG\\BTSG\\src\\main\\webapp\\btsg_upload";
	
	int maxSize=2*1024*1024; //업로드파일의 최대 크기, 2M
	String encoding="utf-8";
	ConcertDAO dao = new ConcertDAO();
	UserVO userVo=null;
	try{
		MultipartRequest mr
			=new MultipartRequest(request, saveDir, 
				maxSize, encoding, new DefaultFileRenamePolicy());
		
		//업로드 파일의 정보
		String upload_name=mr.getFilesystemName("upfile");
		long file_size=0;
		String original_name="";
		if(upload_name!=null){ //파일이 첨부된 경우만
			File file=mr.getFile("upfile");
			file_size=file.length();
			
			original_name=mr.getOriginalFileName("upfile");
		}
		
		//1. 요청 파라미터 읽어오기
		String user_id=(String)session.getAttribute("user_id");
		String concert_no=mr.getParameter("concert_no");
		String content=mr.getParameter("content");
		String rate=mr.getParameter("rate");
		
		
		//ip 읽어오기
		String ip=request.getRemoteAddr();
		String ip2=request.getRemoteHost();
		System.out.println("ip="+ip+", ip2="+ip2);
		
		//2. db작업
		int concertNo=Integer.parseInt(concert_no);
		int review_no=reviewVo.getReview_no();
		
		userVo=userService.selectByUser_id(user_id);
		ReviewVO vo = new ReviewVO();
		vo.setConcert_no(concertNo);
		vo.setUser_no(userVo.getUser_no());
		vo.setContent(content);
		vo.setFile_size(file_size);
		vo.setOriginal_name(original_name);
		vo.setRate(Float.parseFloat(rate));
		vo.setUpload_name(upload_name);
		
		
		int cnt=dao.insertReview(vo);
		vo=dao.selectByNo(concertNo, review_no);
		
		//3. 결과 처리  
		if(cnt>0){ %>
			<script type="text/javascript">
				alert("리뷰작성이 처리되었습니다.");
				location.href="concert_detail.jsp?concert_no="+<%=concertNo %>;
			</script>
	<%  }else{ %>
			<script type="text/javascript">
				alert("리뷰작성 실패!");
				history.back();
			</script>			
	<%	}//if
	}catch(SQLException e){
		e.printStackTrace();
	}catch(IOException e){
		e.printStackTrace(); %>
		<script type="text/javascript">
		alert("2M 이상의 파일은 업로드 불가!");
		history.back();
		</script>
	<%} %>
		
</body>
</html>