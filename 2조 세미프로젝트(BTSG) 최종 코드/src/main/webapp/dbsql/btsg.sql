/* 공연 */
CREATE TABLE concert (
	concert_no NUMBER NOT NULL, /* 공연번호 */
	concert_name VARCHAR2(255) NOT NULL, /* 공연명 */
	hall_address VARCHAR2(255) NOT NULL, /* 콘서트홀 주소 */
	start_date DATE NOT NULL, /* 공연시작일 */
	end_date DATE NOT NULL, /* 공연종료일 */
	original_name VARCHAR2(255), /* 원본파일명 */
	description VARCHAR2(4000) NOT NULL, /* 공연설명 */
	file_size NUMBER, /* 파일사이즈 */
	upload_name VARCHAR2(255), /* 업로드파일명 */
	price NUMBER, /* 가격 */
	rate NUMBER, /* 만족도 */
	soldout VARCHAR2(10) /* 구분(매진) */
);

ALTER TABLE concert
	ADD
		CONSTRAINT PK_concert
		PRIMARY KEY (
			concert_no
		);

/* 회원 */
CREATE TABLE user_ (
	user_no NUMBER NOT NULL, /* 회원번호 */
	user_name VARCHAR2(45) NOT NULL, /* 이름 */
	user_id VARCHAR2(15) NOT NULL, /* 아이디 */
	user_password VARCHAR2(16) NOT NULL, /* 패스워드 */
	nickname VARCHAR2(24) NOT NULL, /* 닉네임 */
	email VARCHAR2(255), /* 이메일 */
	birth VARCHAR2(12) NOT NULL, /* 생년월일 */
	hp VARCHAR2(11) NOT NULL, /* 연락처 */
	zipcode VARCHAR2(15), /* 우편번호 */
	address VARCHAR2(255), /* 주소 */
	addressDetail VARCHAR2(255), /* 주소상세 */
	basic_payment VARCHAR2(30), /* 기본결제수단 */
	card_com VARCHAR2(20), /* 카드사 */
	card_num VARCHAR2(20), /* 카드번호 */
	user_regdate DATE, /* 가입일 */
	delFlag DATE, /* 탈퇴여부 */
	upload_name VARCHAR2(255), /* 업로드파일명 */
	file_size NUMBER, /* 파일사이즈 */
	original_name VARCHAR2(255) /* 원본파일명 */
);

ALTER TABLE user_
	ADD
		CONSTRAINT PK_user_
		PRIMARY KEY (
			user_no
		);

/* 장바구니 */
CREATE TABLE mycart (
	cart_no NUMBER NOT NULL, /* 번호 */
	user_no NUMBER NOT NULL, /* 회원번호 */
	concert_no NUMBER, /* 공연번호 */
	qty NUMBER, /* 수량 */
	delflag VARCHAR2(20) /* 삭제플래그 */
);

ALTER TABLE mycart
	ADD
		CONSTRAINT PK_mycart
		PRIMARY KEY (
			cart_no
		);

/* 구매현황 */
CREATE TABLE purchase (
	purchase_no NUMBER NOT NULL, /* 구매번호 */
	user_no NUMBER NOT NULL, /* 회원번호 */
	concert_no NUMBER, /* 공연번호 */
	con_date VARCHAR2(255), /* 공연선택일 */
	paymentoption VARCHAR2(255), /* 결제방법 */
	price NUMBER, /* 금액 */
	seatType VARCHAR2(255), /* 좌석구역 */
	seatQty NUMBER, /* 예매수량 */
	paymentdate DATE DEFAULT syadate, /* 결제일자 */
	delflag VARCHAR2(20) /* 삭제플래그 */
);

ALTER TABLE purchase
	ADD
		CONSTRAINT PK_purchase
		PRIMARY KEY (
			purchase_no
		);

/* 리뷰 */
CREATE TABLE review (
	review_no NUMBER NOT NULL, /* 후기번호 */
	user_no NUMBER NOT NULL, /* 회원번호 */
	concert_no NUMBER NOT NULL, /* 공연번호 */
	content VARCHAR2(255), /* 내용 */
	original_name VARCHAR2(255), /* 원본파일명 */
	file_size NUMBER, /* 파일사이즈 */
	upload_name VARCHAR2(255), /* 업로드파일명 */
	regdate DATE DEFAULT sysdate, /* 작성일 */
	rate FLOAT, /* 만족도 */
	delflag VARCHAR2(20) /* 삭제플래그 */
);

ALTER TABLE review
	ADD
		CONSTRAINT PK_review
		PRIMARY KEY (
			review_no
		);

ALTER TABLE mycart
	ADD
		CONSTRAINT FK_concert_TO_mycart
		FOREIGN KEY (
			concert_no
		)
		REFERENCES concert (
			concert_no
		);

ALTER TABLE mycart
	ADD
		CONSTRAINT FK_user__TO_mycart
		FOREIGN KEY (
			user_no
		)
		REFERENCES user_ (
			user_no
		);

ALTER TABLE purchase
	ADD
		CONSTRAINT FK_user__TO_purchase
		FOREIGN KEY (
			user_no
		)
		REFERENCES user_ (
			user_no
		);

ALTER TABLE purchase
	ADD
		CONSTRAINT FK_concert_TO_purchase
		FOREIGN KEY (
			concert_no
		)
		REFERENCES concert (
			concert_no
		);

ALTER TABLE review
	ADD
		CONSTRAINT FK_user__TO_review
		FOREIGN KEY (
			user_no
		)
		REFERENCES user_ (
			user_no
		);

ALTER TABLE review
	ADD
		CONSTRAINT FK_concert_TO_review
		FOREIGN KEY (
			concert_no
		)
		REFERENCES concert (
			concert_no
		);
create sequence user_seq
increment by 1
start with 1
nocache;

create sequence concert_seq
increment by 1
start with 1
nocache;

create sequence mycart_seq
increment by 1
start with 1
nocache;


create sequence review_seq
increment by 1
start with 1
nocache;

create sequence purchase_seq
increment by 1
start with 1
nocache;