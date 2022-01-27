package com.btsg.model.DAOs;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.*;

import com.btsg.db.ConnectionPoolMgr;
import com.btsg.model.VOs.ReviewVO;


public class GoodsDAO {

	private ConnectionPoolMgr pool;

	public GoodsDAO() {
		pool=new ConnectionPoolMgr();
	}
	
	public int insertReview(ReviewVO vo) throws SQLException {
		
		Connection con=null;
		PreparedStatement ps=null;
		
		try {
			con=pool.getConnection();
			
			String sql="insert into review(review_no, user_no, concert_no,content, "
					+ "original_name, file_size, upload_name, rate)"
					+ " values(review_seq.nextval,?,?,?,?,?,?,?)"
					+ " ";
			ps=con.prepareStatement(sql);
			
			ps.setInt(1, vo.getUser_no());
			ps.setInt(2, vo.getConcert_no());
			ps.setString(3, vo.getContent());
			ps.setString(4, vo.getOriginal_name());
			ps.setLong(5, vo.getFile_size());
			ps.setString(6, vo.getUpload_name());
			ps.setFloat(7, vo.getRate());
			
			int cnt = ps.executeUpdate();
			System.out.println("�����ۼ� ���� cnt="+cnt+", �Ű����� vo="+vo);
			
			return cnt;
			
		} finally {
			pool.dbClose(ps, con);
		}
	}
	
	public List<ReviewVO> selectAllReview(String condition, String keyword) throws SQLException{
		
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		List<ReviewVO> list=new ArrayList<ReviewVO>();
		
		try {
			con=pool.getConnection();
			
			String sql="select * from review ";
			if(keyword!=null && !keyword.isEmpty()) {
				sql+="where "+condition+" like '%' || ? || '%' ";
			}
			sql+=" order by review_no desc";
			ps=con.prepareStatement(sql);
			
			if(keyword!=null && !keyword.isEmpty()) {
				ps.setString(1, keyword);
			}
			rs=ps.executeQuery();
			while(rs.next()) {
				int review_no=rs.getInt("review_no");
				int user_no=rs.getInt("user_no");
				int concert_no=rs.getInt("concert_no");
				float rate=rs.getFloat("rate");
				String content=rs.getString("content");
				String delFlag=rs.getString("delFlag");
				String upload_name=rs.getString("upload_name");
				String original_name=rs.getString("original_name");
				long file_size=rs.getLong("file_size");
				Timestamp regdate=rs.getTimestamp("regdate");
				
				ReviewVO vo=new ReviewVO(review_no, user_no, concert_no, content, 
						original_name, file_size, upload_name, regdate, rate, delFlag);
				list.add(vo);
			}
			
			System.out.println("������ȸ ��� list.size"+list.size()
				+", keyword="+keyword+", condition="+condition);
			
			return list;
		} finally {
			pool.dbClose(rs, ps, con);
		}
	}
	

}
