package com.btsg.model.DAOs;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.btsg.db.ConnectionPoolMgr;
import com.btsg.model.Services.UserService;
import com.btsg.model.VOs.UserVO;

public class UserDAO {
	ConnectionPoolMgr pool;
	
	public UserDAO() {
		pool=new ConnectionPoolMgr();
	}
	public int insertUser(UserVO vo) throws SQLException {		
		Connection con=null;
		PreparedStatement ps=null;
		
		try {
			con=pool.getConnection();
			
			String sql="insert into user_(user_no, user_name, user_id, user_password, nickname, "
					+ "email, birth, hp)"
					+ " values(user_seq.nextval, ?,?,?,?,?,?,?)";
			ps=con.prepareStatement(sql);
			
			ps.setString(1, vo.getUser_name());
			ps.setString(2, vo.getUser_id());
			ps.setString(3, vo.getUser_password());
			ps.setString(4, vo.getNickname());
			ps.setString(5, vo.getEmail());
			ps.setString(6, vo.getBirth());
			ps.setString(7, vo.getHp());
						
			//4
			int cnt=ps.executeUpdate();
			System.out.println("가입결과 cnt="+cnt+", vo="+vo);
			
			return cnt;
		}finally {
			pool.dbClose(ps, con);
		}
	}
	public UserVO selectByNo(int no) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			con = pool.getConnection();
			
			String sql="select * from user_ where no=?";
			ps=con.prepareStatement(sql);
			
			ps.setInt(1, no);
			
			rs=ps.executeQuery();
			UserVO vo = new UserVO();
			if(rs.next()) {
				String user_name = rs.getString("user_name");
				String user_password = rs.getString("user_password");
				String user_id = rs.getString("user_id");
				String nickname = rs.getString("nickname");
				String email = rs.getString("email");
				String hp = rs.getString("hp");
				String zipcode = rs.getString("zipcode");
				String birth = rs.getString("birth");
				String basic_payment= rs.getString("basic_payment");
				String card_num= rs.getString("card_num");
				String address = rs.getString("address");
				String addressDetail = rs.getString("addressDetail");
				long fileSize= rs.getLong("fileSize");
				String upload_name= rs.getString("upload_name");
				String original_name= rs.getString("original_name");
				Timestamp user_regdate = rs.getTimestamp("user_regdate");
				Timestamp delFlag = rs.getTimestamp("delFlag");
				
				vo.setAddress(address);
				vo.setAddressDetail(addressDetail);
				vo.setBasic_payment(basic_payment);
				vo.setBirth(birth);
				vo.setCard_num(card_num);
				vo.setDelFlag(delFlag);
				vo.setEmail(email);
				vo.setFile_size(fileSize);
				vo.setHp(hp);
				vo.setNickname(nickname);
				vo.setOriginal_name(original_name);
				vo.setUpload_name(upload_name);
				vo.setUser_id(user_id);
				vo.setUser_name(user_name);
				vo.setUser_no(no);
				vo.setUser_password(user_password);
				vo.setUser_regdate(user_regdate);
				vo.setZipcode(zipcode);
				
			}
			return vo;
		}finally {
			pool.dbClose(rs, ps, con);
		}
	}
	public int updateAdditional(UserVO vo) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		System.out.println(vo.getCard_com());
		
		try {
			con = pool.getConnection();

			String sql="update user_"
					+ " set upload_name=?, file_size=?, original_name=?, zipcode=?, address=?, addressDetail=?, basic_payment=?, card_com=?, card_num=?"
					+ " where user_id=?";
			ps=con.prepareStatement(sql);
			
			ps.setString(1, vo.getUpload_name());
			ps.setLong(2, vo.getFile_size());
			ps.setString(3, vo.getOriginal_name());
			ps.setString(4, vo.getZipcode());
			ps.setString(5, vo.getAddress());
			ps.setString(6, vo.getAddressDetail());
			ps.setString(7, vo.getBasic_payment());
			ps.setString(8, vo.getCard_com());
			ps.setString(9, vo.getCard_num());
			ps.setString(10, vo.getUser_id());
			
			int cnt = ps.executeUpdate();
			
			return cnt;
		}finally {
			pool.dbClose(ps, con);
		}
	}
	public int duplicatedId(String user_id) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		int result =0;
		try {
			con = pool.getConnection();
			
			String sql = "select count(*) from user_ where user_id=?";
			ps=con.prepareStatement(sql);
			
			ps.setString(1, user_id);
			
			rs = ps.executeQuery();
			if(rs.next()) {
				int count = rs.getInt(1);
				if(count > 0) {
					result=UserService.EXIST_ID;
				}else {
					result=UserService.NON_EXIST_ID;
				}
			}
			System.out.println("중복확인 result=" + result + ", user_id="+user_id);
			
			return result;
		}finally {
			pool.dbClose(rs, ps, con);
		}
	}
	public UserVO selectByUser_id(String user_id) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			con = pool.getConnection();
			
			String sql="select * from user_ where user_id=?";
			ps=con.prepareStatement(sql);
			
			ps.setString(1, user_id);
			
			rs=ps.executeQuery();
			UserVO vo = new UserVO();
			if(rs.next()) {
				String user_name = rs.getString("user_name");
				String user_password = rs.getString("user_password");
				int no = rs.getInt("user_no");
				String nickname = rs.getString("nickname");
				String email = rs.getString("email");
				String hp = rs.getString("hp");
				String zipcode = rs.getString("zipcode");
				String birth = rs.getString("birth");
				String basic_payment= rs.getString("basic_payment");
				String card_num= rs.getString("card_num");
				String card_com= rs.getString("card_com");
				String address = rs.getString("address");
				String addressDetail = rs.getString("addressDetail");
				long fileSize= rs.getLong("file_size");
				String upload_name= rs.getString("upload_name");
				String original_name= rs.getString("original_name");
				Timestamp user_regdate = rs.getTimestamp("user_regdate");
				Timestamp delFlag = rs.getTimestamp("delFlag");
				
				vo.setAddress(address);
				vo.setAddressDetail(addressDetail);
				vo.setBasic_payment(basic_payment);
				vo.setBirth(birth);
				vo.setCard_num(card_num);
				vo.setDelFlag(delFlag);
				vo.setEmail(email);
				vo.setFile_size(fileSize);
				vo.setHp(hp);
				vo.setNickname(nickname);
				vo.setOriginal_name(original_name);
				vo.setUpload_name(upload_name);
				vo.setUser_id(user_id);
				vo.setUser_name(user_name);
				vo.setCard_com(card_com);
				vo.setUser_no(no);
				vo.setUser_password(user_password);
				vo.setUser_regdate(user_regdate);
				vo.setZipcode(zipcode);
				
			}
			
			return vo;
		}finally {
			pool.dbClose(rs, ps, con);
		}
	}
	public int loginCheck(String user_id, String user_password) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			con = pool.getConnection();
			
			String sql="select user_password from user_ where user_id=?";
			ps=con.prepareStatement(sql);
			
			ps.setString(1, user_id);
			
			rs=ps.executeQuery();
			
			if(rs.next()) {
				String dbPwd = rs.getString(1);
				if(dbPwd.equals(user_password)) {
					return UserService.LOGIN_OK;
				}else {
					return UserService.DISAGREE_PWD;
				}
			}else {
				return UserService.USERID_NONE;
			}
		}finally {
			pool.dbClose(rs, ps, con);
		}
	}
	public List<UserVO> selectAll() throws SQLException{
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		List<UserVO> list = new ArrayList<UserVO>();
		try {
			con = pool.getConnection();
			
			String sql = "select * from user_ order by user_no desc";
			ps = con.prepareStatement(sql);
			
			rs=ps.executeQuery();
			while(rs.next()) {
				int user_no = rs.getInt("user_no");
				String user_name = rs.getString("user_name");
				String user_id = rs.getString("user_id");
				String user_password = rs.getString("user_password");
				String nickname = rs.getString("nickname");
				String email = rs.getString("email");
				String birth = rs.getString("birth");
				String hp = rs.getString("hp");
				String zipcode = rs.getString("zipcode");
				String address = rs.getString("address");
				String addressDetail = rs.getString("addressDetail");
				String basic_payment = rs.getString("basic_payment");
				String card_com = rs.getString("card_com");
				String card_num = rs.getString("card_num");
				Timestamp user_regdate = rs.getTimestamp("user_regdate");
				Timestamp delFlag = rs.getTimestamp("delFlag");
				String upload_name = rs.getString("upload_name");
				int file_size = rs.getInt("file_size");
				String original_name = rs.getString("original_name");
				
				UserVO vo = new UserVO(user_no, user_name, user_id, user_password, nickname, email, birth, hp, zipcode, address, addressDetail, basic_payment, card_com, card_num, user_regdate, delFlag, upload_name, file_size, original_name);
				
				list.add(vo);
			}
			System.out.println("회원 전체조회결과 list.size="+list.size());
			return list;
		}finally {
			pool.dbClose(rs, ps, con);
		}
	}
	public int updateUser(UserVO vo) throws SQLException {
	      Connection con=null;
	      PreparedStatement ps=null;
	      
	      try {
	         //1,2
	         con=pool.getConnection();
	         
	         //3
	         String sql="update user_"
	        		+ " set email=?, hp=?, zipcode=?, address=?, addressDetail=?"
	               + " where user_id=?";
	         ps=con.prepareStatement(sql);
	         
	         ps.setString(1, vo.getEmail());
	         ps.setString(2, vo.getHp());
	         ps.setString(3, vo.getZipcode());
	         ps.setString(4, vo.getAddress());
	         ps.setString(5, vo.getAddressDetail());
	         ps.setString(6, vo.getUser_id());
	                  
	         //4
	         int cnt=ps.executeUpdate();
	         System.out.println("회원수정 결과 cnt="+cnt+", 매개변수 vo="+vo);
	         
	         return cnt;
	      }finally {
	         pool.dbClose(ps, con);
	      }
	   }
	public int editUser(UserVO vo) throws SQLException {
		Connection con = null;
		PreparedStatement ps = null;
		System.out.println(vo.getCard_com());
		
		try {
			con = pool.getConnection();

			String sql="update user_"
					+ " set upload_name=?, file_size=?, original_name=?, zipcode=?, address=?, addressDetail=?, basic_payment=?, card_com=?, card_num=?, nickname =? "
					+ " where user_id=?";
			ps=con.prepareStatement(sql);
			
			ps.setString(1, vo.getUpload_name());
			ps.setLong(2, vo.getFile_size());
			ps.setString(3, vo.getOriginal_name());
			ps.setString(4, vo.getZipcode());
			ps.setString(5, vo.getAddress());
			ps.setString(6, vo.getAddressDetail());
			ps.setString(7, vo.getBasic_payment());
			ps.setString(8, vo.getCard_com());
			ps.setString(9, vo.getCard_num());
			ps.setString(10, vo.getNickname());
			ps.setString(11, vo.getUser_id());
			
			int cnt = ps.executeUpdate();
			System.out.println("cnt="+cnt+"vo ="+vo);
			return cnt;
		}finally {
			pool.dbClose(ps, con);
		}
	}
	public int deleteUser(String user_id) throws SQLException {		
		Connection con=null;
		PreparedStatement ps=null;
		
		try {
			con=pool.getConnection();
			
			String sql="delete from user_ where user_id = ?";
			ps=con.prepareStatement(sql);
			
			ps.setString(1, user_id);
			
						
			//4
			int cnt=ps.executeUpdate();
			System.out.println("삭제결과 cnt="+cnt+", user_id="+user_id);
			
			return cnt;
		}finally {
			pool.dbClose(ps, con);
		}
	}
}
