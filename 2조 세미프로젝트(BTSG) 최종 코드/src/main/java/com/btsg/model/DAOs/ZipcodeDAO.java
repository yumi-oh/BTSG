package com.btsg.model.DAOs;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.btsg.db.ConnectionPoolMgr;
import com.btsg.model.VOs.ZipcodeVO;


public class ZipcodeDAO {
	ConnectionPoolMgr pool;
	
	public ZipcodeDAO() {
		pool= new ConnectionPoolMgr();
	}
	
	public List<ZipcodeVO> selectZipcode(String dong) throws SQLException{
		Connection conn=null;
		PreparedStatement psmt=null;
		ResultSet rs =null;
		List<ZipcodeVO> alist = new ArrayList<ZipcodeVO>();
		try{
			conn = pool.getConnection();
			String sql="select * from zipcode where dong like '%' || ? || '%'";
			psmt = conn.prepareStatement(sql);
			psmt.setString(1, dong);
			rs = psmt.executeQuery();
			while(rs.next()){
				String sido = rs.getString("sido");
				String gugun = rs.getString("gugun");
				dong = rs.getString("dong");
				String sbunji = rs.getString("startbunji");
				String ebunji = rs.getString("endbunji");
				int seq =rs.getInt("seq");
				String zipcode = rs.getString("zipcode");
				ZipcodeVO vo = new ZipcodeVO();
				
				vo.setStartbunji(sbunji);
				vo.setEndbunji(ebunji);
				vo.setDong(dong);
				vo.setGugun(gugun);
				vo.setSeq(seq);
				vo.setSido(sido);
				vo.setZipcode(zipcode);
				alist.add(vo);
			}
			System.out.println("우편번호 조회, alist.size()="+alist.size()+", dong="+dong);
		}finally{
			pool.dbClose(rs, psmt, conn);
		}
			return alist;
		}
}
