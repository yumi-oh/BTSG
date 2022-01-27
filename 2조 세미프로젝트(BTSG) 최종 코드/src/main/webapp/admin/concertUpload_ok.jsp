

<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.io.IOException"%>
<%@page import="com.btsg.common.Utility"%>
<%@page import="java.sql.Date"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.btsg.model.VOs.ConcertVO"%>
<%@page import="com.btsg.model.DAOs.ConcertDAO"%>

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
	//write.jsp에서 post방식으로 서브밋됨
	//post- 요청 파라미터에 대한 한글 인코딩 처리
	request.setCharacterEncoding("utf-8");
	String saveDir=application.getRealPath(Utility.UPLOAD_PATH); //업로드 경로
	saveDir="C:\\Users\\USER\\git\\BTSG\\BTSG\\src\\main\\webapp\\btsg_upload";
	System.out.print(saveDir);
	
	int maxSize=10*1024*1024;  //업로드파일의 최대 크기, 2M
	String encoding="utf-8";
	
	try{
		MultipartRequest mr
		=new MultipartRequest(request, saveDir, maxSize, encoding,
				new DefaultFileRenamePolicy());
		System.out.println("업로드 완료!");
		
		//업로드 파일의 정보 
		String fileName=mr.getFilesystemName("upfile");
		long fileSize=0;
		String originalFName="";
		if(fileName!=null){  //파일이 첨부된 경우만
			File file=mr.getFile("upfile");
			fileSize=file.length();
			
			originalFName=mr.getOriginalFileName("upfile");
		}
	
	
	//1. 요청 파라미터 읽어오기
	String concert_name=mr.getParameter("concert_name");
	String start_date=mr.getParameter("start_date");
	String end_date=mr.getParameter("end_date");
	String description=mr.getParameter("description");
	String price=mr.getParameter("price");
	
	Date startDate=Date.valueOf(start_date);
	Date endDate=Date.valueOf(end_date);
	
	System.out.println(concert_name+" "+start_date+" "+end_date);
	
	//ip 읽어오기
	String ip=request.getRemoteAddr();
	String ip2=request.getRemoteHost();
	System.out.println("ip="+ip+", ip2="+ip2);
	
	//2. db작업
	ConcertDAO dao =new ConcertDAO();
	fileName="../btsg_upload/"+fileName;
	
		ConcertVO vo = new ConcertVO();
		vo.setConcert_name(concert_name);
		vo.setStart_date(startDate);
		vo.setEnd_date(endDate); 
		vo.setUpload_name(fileName);
		vo.setDescription(description);
		vo.setPrice(Integer.parseInt(price));
		
		int cnt=dao.insertBoard(vo);
		//3. 결과 처리  
		if(cnt>0){ %>
			<script type="text/javascript">
				alert("등록 성공 되었습니다.");
				location.href="../concert/concertList.jsp";
			</script>
	<%  }else{ %>
			<script type="text/javascript">
				alert("등록 실패!");
				history.back();
			</script>			
	<%	}//if
	}catch(SQLException e){
		e.printStackTrace();
	}catch(IOException e){ %>
	<script type="text/javascript">
	alert("10M 이상의 파일은 업로드 불가!");
	history.back();
</script>	
 <% e.printStackTrace();
 }	
%>	

</body>
</html>