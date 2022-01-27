package com.btsg.model.VOs;

import java.sql.Timestamp;

public class PurchaseVO {
	private int purchase_no;
	private int user_no;
	private int concert_no;
	private String con_date;
	private String basic_payment;
	private int price;
	private String seatType;
	private int seatQty;
	private Timestamp paymentdate;
	private String delflag;
	
	public PurchaseVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	
	


	public PurchaseVO(int purchase_no, int user_no, int concert_no, String con_date, String basic_payment, int price,
			String seatType, int seatQty, Timestamp paymentdate, String delflag) {
		super();
		this.purchase_no = purchase_no;
		this.user_no = user_no;
		this.concert_no = concert_no;
		this.con_date = con_date;
		this.basic_payment = basic_payment;
		this.price = price;
		this.seatType = seatType;
		this.seatQty = seatQty;
		this.paymentdate = paymentdate;
		this.delflag = delflag;
	}





	public int getPurchase_no() {
		return purchase_no;
	}

	public void setPurchase_no(int purchase_no) {
		this.purchase_no = purchase_no;
	}

	public int getUser_no() {
		return user_no;
	}

	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}

	public int getConcert_no() {
		return concert_no;
	}

	public void setConcert_no(int concert_no) {
		this.concert_no = concert_no;
	}

	public String getBasic_payment() {
		return basic_payment;
	}

	public void setBasic_payment(String basic_payment) {
		this.basic_payment = basic_payment;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public Timestamp getPaymentdate() {
		return paymentdate;
	}

	public void setPaymentdate(Timestamp paymentdate) {
		this.paymentdate = paymentdate;
	}

	public String getDelflag() {
		return delflag;
	}

	public void setDelflag(String delflag) {
		this.delflag = delflag;
	}
	

	public String getSeatType() {
		return seatType;
	}


	public void setSeatType(String seatType) {
		this.seatType = seatType;
	}


	public int getSeatQty() {
		return seatQty;
	}


	public void setSeatQty(int seatQty) {
		this.seatQty = seatQty;
	}
	

	public String getCon_date() {
		return con_date;
	}

	public void setCon_date(String con_date) {
		this.con_date = con_date;
	}

	@Override
	public String toString() {
		return "PurchaseVO [purchase_no=" + purchase_no + ", user_no=" + user_no + ", concert_no=" + concert_no
				+ ", con_date=" + con_date + ", basic_payment=" + basic_payment + ", price=" + price + ", seatType="
				+ seatType + ", seatQty=" + seatQty + ", paymentdate=" + paymentdate + ", delflag=" + delflag + "]";
	}
	
}
