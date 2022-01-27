package com.btsg.model.Services;

import java.sql.SQLException;

import com.btsg.model.DAOs.UserDAO;
import com.btsg.model.VOs.UserVO;

public class UserService {
	public static final int EXIST_ID=1; 
	public static final int NON_EXIST_ID=2;
	
	public static final int LOGIN_OK=1; 
	public static final int DISAGREE_PWD=2;
	public static final int USERID_NONE=3;
	
	private UserDAO userDao;
	
	public UserService() {
		userDao=new UserDAO();
	}
	
	public int insertUser(UserVO vo) throws SQLException {
		int result = userDao.insertUser(vo);
		return result;
	}
	public UserVO selectByNo(int no) throws SQLException {
		UserVO vo = userDao.selectByNo(no);
		return vo;
	}
	public int updateAdditional(UserVO vo) throws SQLException {
		int result = userDao.updateAdditional(vo);
		return result;
	}
	public int duplicatedId(String user_id) throws SQLException {
		int result = userDao.duplicatedId(user_id);
		return result;
	}
	public int loginCheck(String user_id, String user_password) throws SQLException {
		int result = userDao.loginCheck(user_id, user_password);
		return result;
	}
	public UserVO selectByUser_id(String user_id) throws SQLException {
		UserVO vo = userDao.selectByUser_id(user_id);
		return vo;
	}
	 public int updateUser(UserVO vo) throws SQLException {
	      int result = userDao.updateUser(vo);
	      return result;
	 }
	 public int editUser(UserVO vo) throws SQLException {
		 return userDao.editUser(vo);
	 }
	 public int deleteUser(String user_id) throws SQLException {
		 return userDao.deleteUser(user_id);
	 }
}
