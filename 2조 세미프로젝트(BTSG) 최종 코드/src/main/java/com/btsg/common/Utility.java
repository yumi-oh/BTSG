package com.btsg.common;

import java.sql.Timestamp;
import java.util.Date;

public class Utility {
	//�옄猷뚯떎-�뾽濡쒕뱶 寃쎈줈
	public static final String UPLOAD_PATH="uploadFile";
	//�뀒�뒪�듃 寃쎈줈
	public static final String TEST_PATH
	="E:\\java\\lecture\\workspace_list\\btsg_ws\\btsg"
			+ "\\src\\main\\webapp\\uploadFile";

	
	public static String displayRe(int step) {
		//�떟蹂�湲��씤 寃쎌슦 �떒怨꾨퀎濡� �씠誘몄� 蹂댁뿬二쇨린
		
		String result="";
		if(step>0){ 
			for(int k=0;k<step;k++){
			result+="&nbsp";
		}//for 
			result+="<img src='../assets/img/re.gif' alt=''>";
		}//if
		
		return result;
	}
	
	public static String cutString(String content, int len) {
		
		String newTitle=content;
		if(content.length()>len) {
			newTitle=content.substring(0, len)+"...";
		}
		
		return newTitle;
	}
	
	public static String displayNew(Timestamp regdate) {
		//24�떆媛� �씠�궡�쓽 湲��씤 寃쎌슦 new �씠誘몄� 蹂댁뿬二쇨린
		Date sysdate= new Date();
		String result="";
		long gap = (sysdate.getTime()-regdate.getTime())/(60*60*1000);
		if(gap<24) {
			result+="<img src='../assets/img/new.gif' alt='new'>";
		}
		return result;
	}
	
	public static String displayFile(String filename) {
		//�뙆�씪�씠 泥⑤��맂 寃쎌슦 �뙆�씪�씠誘몄� 蹂댁뿬二쇨린
		
		String result="";
		if(filename!=null) {
			result+="<img src='../assets/img/file.gif' alt='file'>";
		}
		return result;
	}
	
	public static String showFileInfo(String oFilename, long filesize) {
		
		String result="";
		if(oFilename!=null && !oFilename.isEmpty()) {
			float fSize=Math.round(filesize/1000f*10)/10f;
			result+=displayFile(oFilename)+" "+oFilename+
					" ("+fSize+"KB)";
		}
		return result;
	}
}
