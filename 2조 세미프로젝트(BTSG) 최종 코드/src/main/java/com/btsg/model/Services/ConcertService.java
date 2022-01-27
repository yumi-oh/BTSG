package com.btsg.model.Services;

import java.sql.SQLException;
import java.util.List;

import com.btsg.model.DAOs.ConcertDetailDAO;
import com.btsg.model.VOs.ConcertVO;
import com.btsg.model.VOs.ReviewVO;

public class ConcertService {
	
	private ConcertDetailDAO concertDao;
	
	public ConcertService() {
		concertDao=new ConcertDetailDAO();
	}
	
	public int insertReview(ReviewVO vo) throws SQLException {
		return concertDao.insertReview(vo);
	}
	
	public List<ReviewVO> selectAllReview(int concert_no) throws SQLException{
		return concertDao.selectAllReview(concert_no);
	}

	public float getAvgRate(int concert_no) throws SQLException {
		return concertDao.getAvgRate(concert_no);
	}
}
