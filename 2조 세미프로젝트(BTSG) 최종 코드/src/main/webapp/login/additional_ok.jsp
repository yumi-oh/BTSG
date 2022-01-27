<%@page import="java.sql.SQLException"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:useBean id="userVO" class="com.btsg.model.VOs.UserVO" scope="page"></jsp:useBean>
<jsp:useBean id="userService" class="com.btsg.model.Services.UserService" scope="session"></jsp:useBean>
<%
	String msg="", url="";
	try{
		String upDir="btsg_upload";
		
		String saveDir = application.getRealPath(upDir);
		saveDir="C:\\Users\\USER\\git\\BTSG\\BTSG\\src\\main\\webapp\\btsg_upload";
		
		int maxSize=20*1024*1024;
		String encoding="utf-8";
		MultipartRequest mr
			= new MultipartRequest(request, saveDir, maxSize, encoding, new DefaultFileRenamePolicy());
		
		System.out.println("업로드!");
		/*if(){
			
		}*/
		String upload_name = mr.getFilesystemName("upload_name");
		String original_name = mr.getOriginalFileName("upload_name");
		long file_size=0;
		if(upload_name!=null){ //파일이 첨부된 경우만
			File file=mr.getFile("upload_name");
			file_size=file.length();
		}
		
		
		String user_id = mr.getParameter("user_id");
		System.out.println(user_id);
		String zipcode =mr.getParameter("zipcode");
		String address =mr.getParameter("address");
		String addressDetail  =mr.getParameter("addressDetail");
		String basic_payment  =mr.getParameter("basic_payment");
		String card_com = mr.getParameter("card_com");
		String card_num1 = mr.getParameter("card_num1");
		String card_num2 = mr.getParameter("card_num2");
		String card_num3 = mr.getParameter("card_num3");
		String card_num4 = mr.getParameter("card_num4");
		
		System.out.println(card_com);
		String card_num="";
		System.out.println("하나");
		
		if(card_num1!=null&& !card_num1.isEmpty()&&
				card_num2!=null&& !card_num2.isEmpty()){
			card_num=card_num1+"-"+card_num2+"-";
		}
		if(card_num3!=null&& !card_num3.isEmpty()&&
				card_num4!=null&& !card_num4.isEmpty()){
			
			card_num+=card_num3+"-"+card_num4;
		}
		userVO= userService.selectByUser_id(user_id);
		System.out.println(userVO);
		userVO.setUpload_name(upload_name);
		userVO.setFile_size(file_size);
		userVO.setOriginal_name(original_name);
		userVO.setAddress(address);
		userVO.setAddressDetail(addressDetail);
		userVO.setZipcode(zipcode);
		userVO.setBasic_payment(basic_payment);
		userVO.setCard_com(card_com);
		userVO.setCard_num(card_num);
		
		int cnt = userService.updateAdditional(userVO);
		if(cnt>0){
			msg="부가정보가 입력되었습니다. 생성한 아이디로 로그인하세요.";
			url="login.jsp";
		}else{
			msg="부가정보 입력 실패!";
			url="additional_info?no="+userVO.getUser_no()+".jsp";
		}
		
	}catch(IOException e){
		e.printStackTrace();
	}catch(SQLException e){
		e.printStackTrace();
	}
	request.setAttribute("msg", msg);
	request.setAttribute("url", url);
%>

<jsp:forward page="../common/message.jsp"></jsp:forward>
</body>
</html>