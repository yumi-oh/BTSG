package com.btsg.model.VOs;

import java.sql.Date;


public class ConcertVO {
	private int concert_no;
	private String concert_name;
	private String hall_address;
	private Date start_date;
	private Date end_date;
	private String description;
	private String upload_name;
	private int price;
	private float rate;
	private String soldout;

	public ConcertVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	

	
	

	
	public ConcertVO(int concert_no, String concert_name, String hall_address, Date start_date, Date end_date,
			String description, String upload_name, int price, float rate, String soldout) {
		super();
		this.concert_no = concert_no;
		this.concert_name = concert_name;
		this.hall_address = hall_address;
		this.start_date = start_date;
		this.end_date = end_date;
		this.description = description;
		this.upload_name = upload_name;
		this.price = price;
		this.rate = rate;
		this.soldout = soldout;
	}






	public int getConcert_no() {
		return concert_no;
	}






	public void setConcert_no(int concert_no) {
		this.concert_no = concert_no;
	}






	public String getConcert_name() {
		return concert_name;
	}






	public void setConcert_name(String concert_name) {
		this.concert_name = concert_name;
	}






	public String getHall_address() {
		return hall_address;
	}






	public void setHall_address(String hall_address) {
		this.hall_address = hall_address;
	}






	public Date getStart_date() {
		return start_date;
	}






	public void setStart_date(Date start_date) {
		this.start_date = start_date;
	}






	public Date getEnd_date() {
		return end_date;
	}






	public void setEnd_date(Date end_date) {
		this.end_date = end_date;
	}






	public String getDescription() {
		return description;
	}






	public void setDescription(String description) {
		this.description = description;
	}






	public String getUpload_name() {
		return upload_name;
	}






	public void setUpload_name(String upload_name) {
		this.upload_name = upload_name;
	}






	public int getPrice() {
		return price;
	}






	public void setPrice(int price) {
		this.price = price;
	}






	public float getRate() {
		return rate;
	}






	public void setRate(float rate) {
		this.rate = rate;
	}






	public String getSoldout() {
		return soldout;
	}






	public void setSoldout(String soldout) {
		this.soldout = soldout;
	}






	@Override
	public String toString() {
		return "ConcertVO [concert_no=" + concert_no + ", concert_name=" + concert_name + ", hall_address="
				+ hall_address + ", start_date=" + start_date + ", end_date=" + end_date + ", description="
				+ description + ", upload_name=" + upload_name + ", price=" + price + ", rate=" + rate + ", soldout="
				+ soldout + "]";
	}






	
	
	
	
}
