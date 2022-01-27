package com.btsg.model.VOs;

public class MycartVO {
	private int cart_no;
	private int user_no;
	private int conert_no;
	private int qty;
	private String delflag;
	
	public MycartVO() {
		super();
	}

	public MycartVO(int cart_no, int user_no, int conert_no, int qty, String delflag) {
		super();
		this.cart_no = cart_no;
		this.user_no = user_no;
		this.conert_no = conert_no;
		this.qty = qty;
		this.delflag = delflag;
	}

	public int getCart_no() {
		return cart_no;
	}

	public void setCart_no(int cart_no) {
		this.cart_no = cart_no;
	}

	public int getUser_no() {
		return user_no;
	}

	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}

	public int getConert_no() {
		return conert_no;
	}

	public void setConert_no(int conert_no) {
		this.conert_no = conert_no;
	}

	public int getQty() {
		return qty;
	}

	public void setQty(int qty) {
		this.qty = qty;
	}

	public String getDelflag() {
		return delflag;
	}

	public void setDelflag(String delflag) {
		this.delflag = delflag;
	}

	@Override
	public String toString() {
		return "MycartVO [cart_no=" + cart_no + ", user_no=" + user_no + ", conert_no=" + conert_no + ", qty=" + qty
				+ ", delflag=" + delflag + "]";
	}


}
