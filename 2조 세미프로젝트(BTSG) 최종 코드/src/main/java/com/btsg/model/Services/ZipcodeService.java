package com.btsg.model.Services;

import java.sql.SQLException;
import java.util.List;

import com.btsg.model.DAOs.ZipcodeDAO;
import com.btsg.model.VOs.ZipcodeVO;

public class ZipcodeService {
	private ZipcodeDAO zipcodeDao;
	
	public ZipcodeService() {
		zipcodeDao=new ZipcodeDAO();
	}
	
	public List<ZipcodeVO> selectZipcode(String dong) throws SQLException{
		return zipcodeDao.selectZipcode(dong);
	}
}
