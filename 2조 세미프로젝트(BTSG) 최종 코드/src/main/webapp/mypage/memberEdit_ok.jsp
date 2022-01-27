<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.btsg.model.Services.UserService"%>
<%@page import="com.btsg.model.DAOs.UserDAO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.File"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>memberEdit_ok.jsp</title>
</head>
<body>
<jsp:useBean id="userVO" class="com.btsg.model.VOs.UserVO" scope="page"></jsp:useBean>
<jsp:useBean id="userService" class="com.btsg.model.Services.UserService" scope="session"></jsp:useBean>

<%
	request.setCharacterEncoding("utf-8");	

	String user_id = (String)session.getAttribute("user_id");
	String email="", hp="", card_num="";
	String msg="회원정보 수정 실패!",	url="mypage.jsp";
	try{
		String upDir="btsg_upload";
		
		String saveDir = application.getRealPath(upDir);
		saveDir="C:\\Users\\USER\\git\\BTSG\\BTSG\\src\\main\\webapp\\btsg_upload";
		
		int maxSize=20*1024*1024;
		String encoding="utf-8";
		MultipartRequest mr
			= new MultipartRequest(request, saveDir, maxSize, encoding, new DefaultFileRenamePolicy());
		
		System.out.println("업로드!");

		String upload_name = mr.getFilesystemName("upload_name");
		String original_name = mr.getOriginalFileName("upload_name");
		long file_size=0;
		if(upload_name!=null){ 
			File file=mr.getFile("upload_name");
			file_size=file.length();
		}
		
		
		
		String user_password = mr.getParameter("user_password");
		String nickname = mr.getParameter("nickname");
		String birth1 = mr.getParameter("birth1");
		String birth2 = mr.getParameter("birth2");
		String hp1 = mr.getParameter("hp1");
		String hp2 = mr.getParameter("hp2");
		String hp3 = mr.getParameter("hp3");
		String email1 = mr.getParameter("email1");
		String email2 = mr.getParameter("email2");
		String email3 = mr.getParameter("email3");
		String zipcode =mr.getParameter("zipcode");
		String address =mr.getParameter("address");
		String addressDetail  =mr.getParameter("addressDetail");
		String basic_payment  =mr.getParameter("basic_payment");
		String card_com = mr.getParameter("card_com");
		String card_num1 = mr.getParameter("card_num1");
		String card_num2 = mr.getParameter("card_num2");
		String card_num3 = mr.getParameter("card_num3");
		String card_num4 = mr.getParameter("card_num4");
		
		if(hp2!=null && !hp2.isEmpty() && hp3 !=null && !hp3.isEmpty()){
			hp=hp1+"-"+hp2+"-"+hp3;
		}
		if(email1!=null && !email1.isEmpty()){
			if(email2.equals("etc")){  //직접입력
				if(email3!=null && !email3.isEmpty()){
					email=email1+"@"+email3;
				}
			}else{
				email=email1+"@"+email2;
			}
		}
	
		if(card_num1!=null && !card_num1.isEmpty() && card_num2!=null && !card_num2.isEmpty() &&
				card_num3!=null && !card_num3.isEmpty() && card_num4!=null && !card_num4.isEmpty()){
			card_num=card_num1+"-"+card_num2+"-"+card_num3+"-"+card_num4;
		}
		
		int result=userService.loginCheck(user_id, user_password);
		
		if(result==UserService.LOGIN_OK){
			userVO.setUser_id(user_id);
			userVO.setAddress(address);
			userVO.setAddressDetail(addressDetail);
			userVO.setBasic_payment(basic_payment);
			userVO.setEmail(email);
			userVO.setHp(hp);
			userVO.setZipcode(zipcode);
			userVO.setNickname(nickname);
			userVO.setCard_com(card_com);
			userVO.setCard_num(card_num);
			userVO.setUpload_name(upload_name);
			userVO.setOriginal_name(original_name);
			userVO.setFile_size(file_size);
			
			int cnt = userService.editUser(userVO);
			
			//3
			if(cnt>0){
				msg="회원정보 수정되었습니다.";
				url="mypage.jsp";
			}
		}
	}catch(SQLException e){
		e.printStackTrace();
	}
	request.setAttribute("msg", msg);
	request.setAttribute("url", url);	
		
%>

<jsp:forward page="../common/message.jsp"></jsp:forward>

</body>
</html>