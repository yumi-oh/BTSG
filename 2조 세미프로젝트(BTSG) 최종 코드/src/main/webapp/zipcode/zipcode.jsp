<%@page import="com.btsg.model.VOs.ZipcodeVO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="zipcodeService" class="com.btsg.model.Services.ZipcodeService" scope="session"></jsp:useBean>

<%
	request.setCharacterEncoding("utf-8");
	String dong = request.getParameter("dong");
	
	List<ZipcodeVO> list = null;
	
	if(dong!=null && !dong.isEmpty()){
		try{
			list=zipcodeService.selectZipcode(dong);
		}catch(SQLException e){
			e.printStackTrace(); 
		}   
	}else{
		dong="";
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/mainstyle.css"/>

<script type="text/javascript" src ="<%=request.getContextPath() %>/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
	function setZipcode(address, zipcode){
		$(opener.document).find('#zipcode').val(zipcode);
		$(opener.document).find('input[name=address]').val(address);
		self.close();
		
	}
	
</script>
<style type="text/css">
	body{ margin:5px;padding:5px;}
	caption{visibility:hidden; }
</style>
</head>
<body>
	<h2><div><I>우편번호 검색</I></div></h2>
	<hr>
	<div>&nbsp;&nbsp;찾고 싶으신 주소의 동(읍/면)을 입력하세요</div>
	<br>
	<div style="background-color:#FAF4F4;">
	<hr>
	<br>
	<form name="frmZipcode" method="post" action="zipcode.jsp">
		<label for="dong">&nbsp;&nbsp;<strong>지역명 :&nbsp; </label>
		<input type="text" name="dong" id="dong" value="<%=dong %>" style="ime-mode:active">
		<input style="background-color: #F7C9C9;" type="submit" id="submit" value="찾기">
	<p>&nbsp;</p>
	<h2>&nbsp;&nbsp;tip</h2>
	<div style="color:#999999">&nbsp;&nbsp;&nbsp;아래와 같은 조합으로 검색을 하시면 더욱 정확한 검색 결과가 검색됩니다.</div>
	<br>
	<p style="color:#999999">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	지역명(읍/면) + 번지</p>
	<p style="color:#B99797">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	예) 삼평동 681, 제주 영평동 2181</p>
	<br>
	<div style="background-color:#e4e4e4;">
	<hr>
	<p style="color:#737373" align="left">&nbsp;&nbsp;&nbsp;&nbsp;powered by BTSG&nbsp;&nbsp;|&nbsp;&nbsp;우편번호 서비스 안내</p>
	<br>
	<br><br>
	<hr>
	</div>
	</form>
	</div>
	<%if(list!=null){ %>
		<table style="width:470px; border:1px solid black" class="box2"
			summary="우편번호 검색 결과에 관한 표로써, 우편번호, 주소에 대한 정보를 제공합니다.">
			<caption>우편번호 검색</caption>
			<colgroup>
			<col style="width:20%" />
			<col style="width:*" />
			</colgroup>
			<thead>
				<tr><th scope="col">우편번호</th><th scope="col">주소</th> </tr>
			</thead>
			<tbody>
				<%if(list==null || list.isEmpty()){ %>
					<tr>
						<td colspan="2">해당하는 데이터가 없습니다.</td>
					</tr>
				<%}else{ 
					for(int i = 0; i<list.size();i++){
						ZipcodeVO vo = list.get(i);
						
						String address = vo.getSido()+" "+vo.getGugun()+" "+ vo.getDong();
						String sbunji=vo.getStartbunji();
						String ebunji = vo.getEndbunji();
						
						String bunji="";
						if(ebunji!=null&&!ebunji.isEmpty()){
							bunji=sbunji+"~"+ebunji;
						}else{
							bunji=sbunji;
						}%>
					<tr>
						<td><%=vo.getZipcode() %></td>
						<td><a href="#" onclick="setZipcode('<%=address %>', '<%=vo.getZipcode() %>')">
						<%=address %> <%=bunji %>
						</a></td>
					</tr>
				<%}
				} %>
			</tbody>
		</table>
		<%}%>
</body>
</html>