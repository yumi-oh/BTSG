package com.btsg.model.DAOs;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.btsg.model.VOs.ConcertListVO;
import com.btsg.model.VOs.ConcertVO;
import com.btsg.model.VOs.MycartVO;
import com.btsg.model.VOs.ReviewVO;
import com.btsg.db.ConnectionPoolMgr;

public class ConcertDAO {
private ConnectionPoolMgr pool;
	
	public ConcertDAO() {
		pool=new ConnectionPoolMgr();
	}
	

	
	public List<ConcertListVO> selectAll() throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		List<ConcertListVO> list=new ArrayList<ConcertListVO>();
		
		try {
			//1,2 con
			con=pool.getConnection();
			
			//3. ps
			String sql="select * from concert";
			ps=con.prepareStatement(sql);
			
			//4. exec
			rs=ps.executeQuery();
			while(rs.next()) {
				int no=rs.getInt("concert_no");
				String cname=rs.getString("concert_name");
				String hall_address=rs.getString("hall_address");
				Timestamp start_date=rs.getTimestamp("start_date");
				Timestamp end_date=rs.getTimestamp("end_date");
				String description=rs.getString("description");
				String upload_name=rs.getString("upload_name");
				int price=rs.getInt("price");
				float rate=rs.getFloat("rate");
				String soldout=rs.getString("soldout");
				
				
				
				
				ConcertListVO vo=new ConcertListVO(no,cname,hall_address,start_date,
						end_date,description,upload_name,price,rate,soldout);
			list.add(vo);
			}
			System.out.println("콘서트 전체 조회 결과, list.size="+list.size());
			
			return list;
		}finally {
			pool.dbClose(rs, ps, con);
		}
	}
	
	public int insertBoard(ConcertVO vo) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		
		try {
			//1,2
			con=pool.getConnection();
			
			//3
			String sql="insert into concert(concert_no, concert_name, hall_address, start_date,"
					+ "end_date, description,upload_name,price)"
					+ " values(concert_seq.nextval, ?,?,?,?,?,?,?)";
			ps=con.prepareStatement(sql);
			
			ps.setString(1, vo.getConcert_name());
			ps.setString(2, vo.getHall_address());
			ps.setDate(3, vo.getStart_date());
			ps.setDate(4, vo.getEnd_date());
			ps.setString(5, vo.getDescription());
			ps.setString(6, vo.getUpload_name());
			ps.setInt(7, vo.getPrice());
			//4
			int cnt=ps.executeUpdate();
			System.out.println("등록 결과 cnt="+cnt+", 매개변수 vo="+vo);
			
			return cnt;
		}finally {
			pool.dbClose(ps, con);
		}
	}
	
	public List<ConcertListVO> selectByNo(List<MycartVO> list)throws
	SQLException{
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		List<ConcertListVO> list2=new ArrayList<ConcertListVO>();
		
		try {
			
			for (int i = 0; i < list.size(); i++) {
				
				MycartVO vo=list.get(i);
				
				con=pool.getConnection();
				String sql="select * from concert"
						+" where concert_no=?";
				ps=con.prepareStatement(sql);
				
				ps.setInt(1, vo.getCart_no());
				rs=ps.executeQuery();
				
				if(rs.next()) {
					int no=rs.getInt("concert_no");
					String cname=rs.getString("concert_name");
					String hall_address=rs.getString("hall_address");
					Timestamp start_date=rs.getTimestamp("start_date");
					Timestamp end_date=rs.getTimestamp("end_date");
					String description=rs.getString("description");
					String upload_name=rs.getString("upload_name");
					int price=rs.getInt("price");
					float rate=rs.getFloat("rate");
					String soldout=rs.getString("soldout");
					
					ConcertListVO vo2=new ConcertListVO(no,cname,hall_address,start_date,
							end_date,description,upload_name,price,rate,soldout);
				list2.add(vo2);
					
				}
			}
			System.out.println("콘서트 검색 결과 list.size="+list2.size());
			return list2;
		}finally {
			pool.dbClose(rs, ps, con);
		}
			
	}
	

	/**
	 * 콘서트 상세보기 메서드
	 * @param concert_no
	 * @return
	 * @throws SQLException
	 */
	public ConcertVO selectByNo(int concert_no) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		ConcertVO vo=new ConcertVO();
		try {
			//1,2
			con=pool.getConnection();
			
			//3
			String sql="select * from concert where concert_no=?";
			ps=con.prepareStatement(sql);
			ps.setInt(1, concert_no);
			
			//4
			rs=ps.executeQuery();
			if(rs.next()) {
				String concert_name=rs.getString("concert_name");
				String hall_address=rs.getString("hall_address");
				Date start_date=rs.getDate("start_date");
				Date end_date=rs.getDate("end_date");
				String upload_name=rs.getString("upload_name");
				int price=rs.getInt("price");
				float rate=rs.getFloat("rate");
				String soldout=rs.getString("soldout");
				String description=rs.getString("description");
				
				vo.setConcert_no(concert_no);
				vo.setConcert_name(concert_name);
				vo.setStart_date(start_date);
				vo.setEnd_date(end_date);
				vo.setUpload_name(upload_name);
				vo.setPrice(price);
				vo.setRate(rate);
				vo.setSoldout(soldout);
				vo.setHall_address(hall_address);
				vo.setDescription(description);
				
			}
			System.out.println("상세보기 결과 vo="+vo+", 매개변수 concert_no="+concert_no);
			
			return vo;
		}finally {
			pool.dbClose(rs, ps, con);
		}
	}	
	
	/**
	 * 리뷰 입력 메서드
	 * @param vo
	 * @return
	 * @throws SQLException
	 */
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
			System.out.println("리뷰작성 성공 cnt="+cnt+", 매개변수 vo="+vo);
			
			return cnt;
			
		} finally {
			pool.dbClose(ps, con);
		}
	}

	/**
	 * 리뷰 상세보기 메서드 - 콘서트 번호, 리뷰 번호로 조회
	 * @param concert_no
	 * @param review_no
	 * @return
	 * @throws SQLException
	 */
	public ReviewVO selectByNo(int concert_no, int review_no) throws SQLException {
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		ReviewVO vo=new ReviewVO();
		try {
			//1,2
			con=pool.getConnection();
			
			//3
			String sql="select * from review where concert_no=? and "
					+ "review_no=?";
			ps=con.prepareStatement(sql);
			ps.setInt(1, concert_no);
			ps.setInt(2, review_no);
			
			//4
			rs=ps.executeQuery();
			if(rs.next()) {
				int user_no=rs.getInt("user_no");
				float rate=rs.getFloat("rate");
				String content=rs.getString("content");
				String delFlag=rs.getString("delFlag");
				String upload_name=rs.getString("upload_name");
				String original_name=rs.getString("original_name");
				long file_size=rs.getLong("file_size");
				Timestamp regdate=rs.getTimestamp("regdate");
				
				vo.setContent(content);
				vo.setConcert_no(concert_no);
				vo.setDelflag(delFlag);
				vo.setFile_size(file_size);
				vo.setOriginal_name(original_name);
				vo.setRate(rate);
				vo.setRegdate(regdate);
				vo.setReview_no(review_no);
				vo.setUpload_name(upload_name);
				vo.setUser_no(user_no);
				
			}
			System.out.println("상세보기 결과 vo="+vo+", 매개변수 concert_no="+concert_no
					+", review_no="+review_no);
			
			return vo;
		}finally {
			pool.dbClose(rs, ps, con);
		}
	}

	public List<ReviewVO> selectAllReview(int concert_no) throws SQLException{
		
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		
		List<ReviewVO> list=new ArrayList<ReviewVO>();
		
		try {
			con=pool.getConnection();
			

			String sql="select * from review "
					+ "where concert_no=? "
					+ "order by review_no desc";
			ps=con.prepareStatement(sql);
			
			ps.setInt(1, concert_no);
			

			rs=ps.executeQuery();
			while(rs.next()) {
				int review_no=rs.getInt("review_no");
				int user_no=rs.getInt("user_no");
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
			
			System.out.println("리뷰조회 결과 list.size"+list.size()
					+", concert_no="+concert_no);
			
			return list;
		} finally {
			pool.dbClose(rs, ps, con);
		}
	}
	
	/**
	 * 콘서트별 리뷰평점 평균 구하기 메서드
	 * @param concert_no
	 * @return
	 * @throws SQLException
	 */
	public float getAvgRate(int concert_no) throws SQLException {
	    
		Connection con=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		    
		try {
			con=pool.getConnection();
			       
			String sql="select count(*) from review"
					+ " where concert_no=?";
			ps=con.prepareStatement(sql);
				      
			ps.setInt(1, concert_no);
				  
			rs=ps.executeQuery();
			int totalRecord = 0;
			if(rs.next()) {
				totalRecord=rs.getInt(1);
			}
			   
			sql="select rate from review"
					+ " where concert_no=?";
			ps=con.prepareStatement(sql);
			   
			ps.setInt(1, concert_no);
			   
			rs=ps.executeQuery();
			float rate=0f;
			float total=0f;
			ConcertVO concertVo=new ConcertVO();
			while(rs.next()) {
				rate=rs.getInt(1);
				      
				total+=rate;
			}
			float totalRate = ((int)(total/totalRecord*10))/10f;
			System.out.println("콘서트별 후기 평점 평균 rate="+totalRate+", "
					+ "concert_no="+concert_no);
			       
			return totalRate;
		} finally {
			pool.dbClose(rs, ps, con);
		}
	}
	
	
		
}
