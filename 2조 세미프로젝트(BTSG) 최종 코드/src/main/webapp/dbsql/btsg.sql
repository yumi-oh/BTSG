/* ���� */
CREATE TABLE concert (
	concert_no NUMBER NOT NULL, /* ������ȣ */
	concert_name VARCHAR2(255) NOT NULL, /* ������ */
	hall_address VARCHAR2(255) NOT NULL, /* �ܼ�ƮȦ �ּ� */
	start_date DATE NOT NULL, /* ���������� */
	end_date DATE NOT NULL, /* ���������� */
	original_name VARCHAR2(255), /* �������ϸ� */
	description VARCHAR2(4000) NOT NULL, /* �������� */
	file_size NUMBER, /* ���ϻ����� */
	upload_name VARCHAR2(255), /* ���ε����ϸ� */
	price NUMBER, /* ���� */
	rate NUMBER, /* ������ */
	soldout VARCHAR2(10) /* ����(����) */
);

ALTER TABLE concert
	ADD
		CONSTRAINT PK_concert
		PRIMARY KEY (
			concert_no
		);

/* ȸ�� */
CREATE TABLE user_ (
	user_no NUMBER NOT NULL, /* ȸ����ȣ */
	user_name VARCHAR2(45) NOT NULL, /* �̸� */
	user_id VARCHAR2(15) NOT NULL, /* ���̵� */
	user_password VARCHAR2(16) NOT NULL, /* �н����� */
	nickname VARCHAR2(24) NOT NULL, /* �г��� */
	email VARCHAR2(255), /* �̸��� */
	birth VARCHAR2(12) NOT NULL, /* ������� */
	hp VARCHAR2(11) NOT NULL, /* ����ó */
	zipcode VARCHAR2(15), /* �����ȣ */
	address VARCHAR2(255), /* �ּ� */
	addressDetail VARCHAR2(255), /* �ּһ� */
	basic_payment VARCHAR2(30), /* �⺻�������� */
	card_com VARCHAR2(20), /* ī��� */
	card_num VARCHAR2(20), /* ī���ȣ */
	user_regdate DATE, /* ������ */
	delFlag DATE, /* Ż�𿩺� */
	upload_name VARCHAR2(255), /* ���ε����ϸ� */
	file_size NUMBER, /* ���ϻ����� */
	original_name VARCHAR2(255) /* �������ϸ� */
);

ALTER TABLE user_
	ADD
		CONSTRAINT PK_user_
		PRIMARY KEY (
			user_no
		);

/* ��ٱ��� */
CREATE TABLE mycart (
	cart_no NUMBER NOT NULL, /* ��ȣ */
	user_no NUMBER NOT NULL, /* ȸ����ȣ */
	concert_no NUMBER, /* ������ȣ */
	qty NUMBER, /* ���� */
	delflag VARCHAR2(20) /* �����÷��� */
);

ALTER TABLE mycart
	ADD
		CONSTRAINT PK_mycart
		PRIMARY KEY (
			cart_no
		);

/* ������Ȳ */
CREATE TABLE purchase (
	purchase_no NUMBER NOT NULL, /* ���Ź�ȣ */
	user_no NUMBER NOT NULL, /* ȸ����ȣ */
	concert_no NUMBER, /* ������ȣ */
	con_date VARCHAR2(255), /* ���������� */
	paymentoption VARCHAR2(255), /* ������� */
	price NUMBER, /* �ݾ� */
	seatType VARCHAR2(255), /* �¼����� */
	seatQty NUMBER, /* ���ż��� */
	paymentdate DATE DEFAULT syadate, /* �������� */
	delflag VARCHAR2(20) /* �����÷��� */
);

ALTER TABLE purchase
	ADD
		CONSTRAINT PK_purchase
		PRIMARY KEY (
			purchase_no
		);

/* ���� */
CREATE TABLE review (
	review_no NUMBER NOT NULL, /* �ı��ȣ */
	user_no NUMBER NOT NULL, /* ȸ����ȣ */
	concert_no NUMBER NOT NULL, /* ������ȣ */
	content VARCHAR2(255), /* ���� */
	original_name VARCHAR2(255), /* �������ϸ� */
	file_size NUMBER, /* ���ϻ����� */
	upload_name VARCHAR2(255), /* ���ε����ϸ� */
	regdate DATE DEFAULT sysdate, /* �ۼ��� */
	rate FLOAT, /* ������ */
	delflag VARCHAR2(20) /* �����÷��� */
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