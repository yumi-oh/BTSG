package com.btsg.model.VOs;

import java.sql.Timestamp;

public class UserVO {
	private int user_no;
	private String user_name;
	private String user_id;
	private String user_password;
	private String nickname;
	private String email;
	private String birth;
	private String hp;
	private String zipcode;
	private String address;
	private String addressDetail;
	private String basic_payment;
	private String card_com;
	private String card_num;
	private Timestamp user_regdate;
	private Timestamp delFlag;
	private String upload_name;
	private long file_size;
	private String original_name;
	
	public UserVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	

	public UserVO(int user_no, String user_name, String user_id, String user_password, String nickname, String email,
			String birth, String hp, String zipcode, String address, String addressDetail, String basic_payment,
			String card_com, String card_num, Timestamp user_regdate, Timestamp delFlag, String upload_name,
			long file_size, String original_name) {
		super();
		this.user_no = user_no;
		this.user_name = user_name;
		this.user_id = user_id;
		this.user_password = user_password;
		this.nickname = nickname;
		this.email = email;
		this.birth = birth;
		this.hp = hp;
		this.zipcode = zipcode;
		this.address = address;
		this.addressDetail = addressDetail;
		this.basic_payment = basic_payment;
		this.card_com = card_com;
		this.card_num = card_num;
		this.user_regdate = user_regdate;
		this.delFlag = delFlag;
		this.upload_name = upload_name;
		this.file_size = file_size;
		this.original_name = original_name;
	}



	public int getUser_no() {
		return user_no;
	}

	public void setUser_no(int user_no) {
		this.user_no = user_no;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public String getUser_password() {
		return user_password;
	}

	public void setUser_password(String user_password) {
		this.user_password = user_password;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getBirth() {
		return birth;
	}

	public void setBirth(String birth) {
		this.birth = birth;
	}

	public String getHp() {
		return hp;
	}

	public void setHp(String hp) {
		this.hp = hp;
	}

	public String getZipcode() {
		return zipcode;
	}

	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getAddressDetail() {
		return addressDetail;
	}

	public void setAddressDetail(String addressDetail) {
		this.addressDetail = addressDetail;
	}

	public String getBasic_payment() {
		return basic_payment;
	}

	public void setBasic_payment(String basic_payment) {
		this.basic_payment = basic_payment;
	}

	public String getCard_com() {
		return card_com;
	}

	public void setCard_com(String card_com) {
		this.card_com = card_com;
	}

	public String getCard_num() {
		return card_num;
	}

	public void setCard_num(String card_num) {
		this.card_num = card_num;
	}

	public Timestamp getUser_regdate() {
		return user_regdate;
	}

	public void setUser_regdate(Timestamp user_regdate) {
		this.user_regdate = user_regdate;
	}

	public Timestamp getDelFlag() {
		return delFlag;
	}

	public void setDelFlag(Timestamp delFlag) {
		this.delFlag = delFlag;
	}

	public String getUpload_name() {
		return upload_name;
	}

	public void setUpload_name(String upload_name) {
		this.upload_name = upload_name;
	}

	public long getFile_size() {
		return file_size;
	}

	public void setFile_size(long file_size) {
		this.file_size = file_size;
	}

	public String getOriginal_name() {
		return original_name;
	}

	public void setOriginal_name(String original_name) {
		this.original_name = original_name;
	}

	@Override
	public String toString() {
		return "UserVO [user_no=" + user_no + ", user_name=" + user_name + ", user_id=" + user_id + ", user_password="
				+ user_password + ", nickname=" + nickname + ", email=" + email + ", birth=" + birth + ", hp=" + hp
				+ ", zipcode=" + zipcode + ", address=" + address + ", addressDetail=" + addressDetail
				+ ", basic_payment=" + basic_payment + ", card_com=" + card_com + ", card_num=" + card_num
				+ ", user_regdate=" + user_regdate + ", delFlag=" + delFlag + ", upload_name=" + upload_name
				+ ", file_size=" + file_size + ", original_name=" + original_name + "]";
	}
	
	
	
	
}
