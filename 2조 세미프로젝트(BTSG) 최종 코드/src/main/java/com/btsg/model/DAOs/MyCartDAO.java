package com.btsg.model.DAOs;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.btsg.db.ConnectionPoolMgr;
import com.btsg.model.VOs.MycartVO;

public class MyCartDAO {
	private ConnectionPoolMgr pool;
	
	public MyCartDAO() {
		pool=new ConnectionPoolMgr();
	}
	
	public List<MycartVO> selectByNo(int user_no) throws SQLException{
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		List<MycartVO> list=new ArrayList<MycartVO>();
		
		try {
			
			con=pool.getConnection();
			
			String sql="select * from mycart  "
					+"where user_no=?";
			ps=con.prepareStatement(sql);
			
			ps.setInt(1, user_no);
			
			
			rs=ps.executeQuery();
			while(rs.next()) {
				int cart_no=rs.getInt("cart_no");
				int concert_no=rs.getInt("concert_no");
				int qty=rs.getInt("qty");
				String delflag=rs.getString("delflag");
				
				
				MycartVO vo2=new MycartVO(cart_no,user_no,concert_no,qty,delflag);
				list.add(vo2);
			}
			System.out.println("장바구니 검색 결과 list.size="+list.size());
			
			return list;
					
		}finally {
			pool.dbClose(rs, ps, con);
		}
	}
	public int insertMyCart(MycartVO vo) throws SQLException{
		Connection con=null;
		PreparedStatement ps=null;
		
		
		try {
			
			con=pool.getConnection();
			
			String sql="insert into mycart(cart_no, user_no, concert_no, qty)"
					+" values(mycart_seq.nextval, ? ,?, ?)";
			ps=con.prepareStatement(sql);
			
			ps.setInt(1, vo.getUser_no());
			ps.setInt(2, vo.getConert_no());
			ps.setInt(3, 2);
			
			
			int cnt = ps.executeUpdate();

			System.out.println("장바구니 담기 vo="+vo);
			
			return cnt;
					
		}finally {
			pool.dbClose(ps, con);
		}
	}
}
