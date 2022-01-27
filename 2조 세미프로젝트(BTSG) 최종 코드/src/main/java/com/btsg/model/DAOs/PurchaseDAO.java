package com.btsg.model.DAOs;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.btsg.db.ConnectionPoolMgr;
import com.btsg.model.VOs.PurchaseVO;

public class PurchaseDAO {
	private ConnectionPoolMgr pool;
	
	public PurchaseDAO() {
		pool=new ConnectionPoolMgr();
	}
	

	public int insertPurchase(PurchaseVO vo) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		
		try {
			//1,2
			con=pool.getConnection();
			
			//3
			String sql="insert into purchase(purchase_no, user_no, concert_no, basic_payment,price, seatType, seatQty,con_date)"
					+ " values(purchase_seq.nextval, ?,?,?,?,?,?,?)";
			ps=con.prepareStatement(sql);
			
			ps.setInt(1, vo.getUser_no());
			ps.setInt(2, vo.getConcert_no());
			ps.setString(3, vo.getBasic_payment());
			ps.setInt(4, vo.getPrice());
			ps.setString(5, vo.getSeatType());
			ps.setInt(6, vo.getSeatQty());
			ps.setString(7, vo.getCon_date());			
			
			//4
			int cnt=ps.executeUpdate();
			System.out.println("등록 결과 cnt="+cnt+", 매개변수 vo="+vo);
			
			return cnt;
		}finally {
			pool.dbClose(ps, con);
		}
	}
	
	public List<PurchaseVO> selectByUserNo(int user_no) throws SQLException{
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		List<PurchaseVO> list = new ArrayList<PurchaseVO>();
		try {
			con = pool.getConnection();
			
			String sql = "select * from purchase where user_no=? order by purchase_no desc";
			ps = con.prepareStatement(sql);
			
			ps.setInt(1, user_no);
			
			rs=ps.executeQuery();
			while(rs.next()) {
				int purchase_no = rs.getInt("purchase_no");
				int concert_no = rs.getInt("concert_no");
				String con_date = rs.getString("con_date");
				String basic_payment = rs.getString("basic_payment");
				int price = rs.getInt("price");
				String seatType = rs.getString("seatType");
				int seatQty = rs.getInt("seatQty");
				Timestamp paymentdate = rs.getTimestamp("paymentdate");
				String delflag = rs.getString("delflag");
				
				PurchaseVO vo = new PurchaseVO(purchase_no, user_no, concert_no, con_date, basic_payment, 
						price, seatType, seatQty, paymentdate, delflag);
				
				list.add(vo);
			}
			System.out.println("예매내역 조회 list.size="+list.size());
			return list;
		}finally {
			pool.dbClose(rs, ps, con);
		}
	}
	public PurchaseVO selectByPurchaseNo(int purchase_no) throws SQLException{
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			con = pool.getConnection();
			
			String sql = "select * from purchase where purchase_no=? order by purchase_no desc";
			ps = con.prepareStatement(sql);
			
			ps.setInt(1, purchase_no);
			
			rs=ps.executeQuery();
			PurchaseVO vo = null;
			if(rs.next()) {
				int concert_no = rs.getInt("concert_no");
				int user_no = rs.getInt("user_no");
				String con_date = rs.getString("con_date");
				String basic_payment = rs.getString("basic_payment");
				int price = rs.getInt("price");
				String seatType = rs.getString("seatType");
				int seatQty = rs.getInt("seatQty");
				Timestamp paymentdate = rs.getTimestamp("paymentdate");
				String delflag = rs.getString("delflag");
				
				vo = new PurchaseVO(purchase_no, user_no, concert_no, con_date, basic_payment, 
						price, seatType, seatQty, paymentdate, delflag);
			}
			return vo;
		}finally {
			pool.dbClose(rs, ps, con);
		}
	}
}
