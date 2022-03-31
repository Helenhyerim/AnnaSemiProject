show user;
-- USER?΄(κ°?) "SEMIORAUSER2"???€.

grant connect, resource, create view, unlimited tablespace to SEMIORAUSER2;

select * from anna_test;

select * 
from tab;



------------------------

/* ? ? */
CREATE TABLE tbl_product (
	productnum NUMBER(8) NOT NULL, /* ? ?λ²νΈ */
	categorynum NUMBER(8) NOT NULL, /* μΉ΄νκ³ λ¦¬??λΆλ₯λ²νΈ */
	productname VARCHAR2(100) NOT NULL, /* ? ?λͺ? */
	productcompany VARCHAR2(50), /* ? μ‘°ν?¬λͺ? */
	productimage1 VARCHAR2(100), /* ???? ??΄λ―Έμ?1 */
	productimage2 VARCHAR2(100), /* ???? ??΄λ―Έμ?2 */
	productqty NUMBER(8) DEFAULT 0, /* ? ??¬κ³ λ */
	productprice NUMBER(8) DEFAULT 0, /* ? ?? κ°? */
	saleprice NUMBER(8) DEFAULT 0, /* ? ??λ§€κ? */
	fk_specnum NUMBER(8), /* ?€?λ²νΈ */
	productcontent VARCHAR2(4000), /* ? ??€λͺ? */
	point NUMBER(8) DEFAULT 0, /* ? λ¦½κΈ */
	productinputdate DATE DEFAULT sysdate /* ? ??κ³ μΌ? */
);

CREATE UNIQUE INDEX PK_tbl_product
	ON tbl_product (
		productnum ASC
	);

ALTER TABLE tbl_product
	ADD
		CONSTRAINT PK_tbl_product
		PRIMARY KEY (
			productnum
		);

/* ? ?μΆκ??΄λ―Έμ? */
CREATE TABLE tbl_product_imagefile (
	imagefilenum NUMBER NOT NULL, /* ?΄λ―Έμ?λ²νΈ */
	fk_productnum NUMBER(8) NOT NULL, /* ? ?λ²νΈ */
	imagefilename VARCHAR2(100) NOT NULL /* ?΄λ―Έμ???Όλͺ? */
);

CREATE UNIQUE INDEX PK_tbl_product_imagefile
	ON tbl_product_imagefile (
		imagefilenum ASC
	);

ALTER TABLE tbl_product_imagefile
	ADD
		CONSTRAINT PK_tbl_product_imagefile
		PRIMARY KEY (
			imagefilenum
		);

/* μΉ΄νκ³ λ¦¬ */
CREATE TABLE tbl_category (
	categorynum NUMBER(8) NOT NULL, /* μΉ΄νκ³ λ¦¬??λΆλ₯λ²νΈ */
	code VARCHAR2(20) NOT NULL, /* μΉ΄νκ³ λ¦¬μ½λ */
	categoryname VARCHAR2(100) NOT NULL /* μΉ΄νκ³ λ¦¬λͺ? */
);

CREATE UNIQUE INDEX PK_tbl_category
	ON tbl_category (
		categorynum ASC
	);

CREATE UNIQUE INDEX UIX_tbl_category
	ON tbl_category (
		code ASC
	);

ALTER TABLE tbl_category
	ADD
		CONSTRAINT PK_tbl_category
		PRIMARY KEY (
			categorynum
		);

ALTER TABLE tbl_category
	ADD
		CONSTRAINT UK_tbl_category
		UNIQUE (
			code
		);

/* ? ??€? */
CREATE TABLE tbl_spec (
	specnum NUMBER(8) NOT NULL, /* ?€?λ²νΈ */
	specname VARCHAR2(100) NOT NULL /* ?€?λͺ? */
);

CREATE UNIQUE INDEX PK_tbl_spec
	ON tbl_spec (
		specnum ASC
	);

CREATE UNIQUE INDEX UIX_tbl_spec
	ON tbl_spec (
		specname ASC
	);

ALTER TABLE tbl_spec
	ADD
		CONSTRAINT PK_tbl_spec
		PRIMARY KEY (
			specnum
		);

ALTER TABLE tbl_spec
	ADD
		CONSTRAINT UK_tbl_spec
		UNIQUE (
			specname
		);

/* ?₯λ°κ΅¬? */
CREATE TABLE tbl_cart (
	cartno NUMBER NOT NULL, /* ?₯λ°κ΅¬?λ²νΈ */
	fk_userid VARCHAR2(20) NOT NULL, /* ????΄? */
	fk_productnum NUMBER(8) NOT NULL, /* ? ?λ²νΈ */
	orderqty NUMBER(4) DEFAULT 0, /* μ£Όλ¬Έ? */
	registerday DATE DEFAULT sysdate /* ?? ₯?Ό? */
);

CREATE UNIQUE INDEX PK_tbl_cart
	ON tbl_cart (
		cartno ASC
	);

ALTER TABLE tbl_cart
	ADD
		CONSTRAINT PK_tbl_cart
		PRIMARY KEY (
			cartno
		);

/* μ°νκΈ? */
CREATE TABLE tbl_dibs (
	fk_productnum NUMBER(8) NOT NULL, /* ? ?λ²νΈ */
	fk_userid VARCHAR2(20) NOT NULL /* ????΄? */
);

/* κ³΅μ??¬?­ */
CREATE TABLE tbl_notice (
	noticeno NUMBER NOT NULL, /* κ³΅μ??¬?­λ²νΈ */
	fk_userid VARCHAR2(20) NOT NULL, /* ????΄? */
	noticedate DATE DEFAULT sysdate NOT NULL, /* ??±?Ό? */
	noticetitle VARCHAR2(100) NOT NULL, /* κΈ?? λͺ? */
	noticecontents VARCHAR2(4000) NOT NULL /* κΈ??΄?© */
);

CREATE UNIQUE INDEX PK_tbl_notice
	ON tbl_notice (
		noticeno ASC
	);

ALTER TABLE tbl_notice
	ADD
		CONSTRAINT PK_tbl_notice
		PRIMARY KEY (
			noticeno
		);

/* ?΄λ²€νΈ */
CREATE TABLE tbl_event (
	eventno NUMBER NOT NULL, /* ?΄λ²€νΈλ²νΈ */
	userid VARCHAR2(20) NOT NULL, /* ????΄? */
	eventdate DATE DEFAULT sysdate NOT NULL, /* ??±?Ό? */
	eventtitle VARCHAR2(100) NOT NULL, /* κΈ?? λͺ? */
	eventcontents VARCHAR2(4000) NOT NULL, /* κΈ??΄?© */
	imagefilename VARCHAR2(100), /* ?΄λ―Έμ? */
	eventstartdate DATE NOT NULL, /* ?΄λ²€νΈ???Ό */
	eventenddate DATE /* ?΄λ²€νΈμ’λ£?Ό */
);

CREATE UNIQUE INDEX PK_tbl_event
	ON tbl_event (
		eventno ASC
	);

ALTER TABLE tbl_event
	ADD
		CONSTRAINT PK_tbl_event
		PRIMARY KEY (
			eventno
		);

/* ? ?κ΅¬λ§€?κΈ°λ¦¬λ·? */
CREATE TABLE tbl_purchase_reviews (
	review_no NUMBER NOT NULL, /* ??±λ²νΈ */
	fk_userid VARCHAR2(20) NOT NULL, /* ????΄? */
	fk_productnum NUMBER(8) NOT NULL, /* ? ?λ²νΈ */
	reviewcontents VARCHAR2(4000) NOT NULL, /* λ¦¬λ·°?΄?© */
	reviewdate DATE DEFAULT sysdate /* ??±?Ό? */
);

CREATE UNIQUE INDEX PK_tbl_purchase_reviews
	ON tbl_purchase_reviews (
		review_no ASC
	);

ALTER TABLE tbl_purchase_reviews
	ADD
		CONSTRAINT PK_tbl_purchase_reviews
		PRIMARY KEY (
			review_no
		);

/* FAQ */
CREATE TABLE tbl_faq (
	faqno NUMBER NOT NULL, /* FAQλ²νΈ */
	fk_userid VARCHAR2(20) NOT NULL, /* ????΄? */
	faqrequesttype VARCHAR2(20) NOT NULL, /* λ¬ΈμλΆλ₯ */
	faqtitle VARCHAR2(100) NOT NULL, /* κΈ?? λͺ? */
	faqcontents VARCHAR2(4000) NOT NULL /* κΈ??΄?© */
);

CREATE UNIQUE INDEX PK_tbl_faq
	ON tbl_faq (
		faqno ASC
	);

ALTER TABLE tbl_faq
	ADD
		CONSTRAINT PK_tbl_faq
		PRIMARY KEY (
			faqno
		);

/* QnA */
CREATE TABLE tbl_qna (
	qnano NUMBER NOT NULL, /* QnAλ²νΈ */
	fk_userid VARCHAR2(20) NOT NULL, /* ????΄? */
	questiontitle VARCHAR2(100) NOT NULL, /* μ§λ¬Έ? λͺ? */
	questioncontents VARCHAR2(4000) NOT NULL, /* μ§λ¬Έ?΄?© */
	questiondate DATE DEFAULT sysdate NOT NULL, /* μ§λ¬Έ??±?Ό? */
	answertitle VARCHAR2(100), /* ?΅λ³?? λͺ? */
	answercontents VARCHAR2(4000), /* ?΅λ³??΄?© */
	answerdate DATE DEFAULT sysdate /* ?΅λ³???±?Ό? */
);

CREATE UNIQUE INDEX PK_tbl_qna
	ON tbl_qna (
		qnano ASC
	);

ALTER TABLE tbl_qna
	ADD
		CONSTRAINT PK_tbl_qna
		PRIMARY KEY (
			qnano
		);

/* λ‘κ·Έ?ΈκΈ°λ‘ */
CREATE TABLE tbl_loginhistory (
	fk_userid VARCHAR2(20), /* ????΄? */
	logindate DATE DEFAULT sysdate NOT NULL, /* λ‘κ·Έ?Έ? μ§μκ°? */
	clientip VARCHAR2(20) /* ? ?IPμ£Όμ */
);

/* ?? */
CREATE TABLE tbl_member (
	userid VARCHAR2(20) NOT NULL, /* ????΄? */
	pwd VARCHAR2(200) NOT NULL, /* ??λΉλ?λ²νΈ */
	name VARCHAR2(30) NOT NULL, /* ??λͺ? */
	email VARCHAR2(200) NOT NULL, /* ?΄λ©μΌ */
	mobile VARCHAR2(200), /* ?΄???°λ²νΈ */
	postcode VARCHAR2(10), /* ?°?Έλ²νΈ */
	address VARCHAR2(200), /* μ£Όμ */
	detailaddress VARCHAR2(200), /* ??Έμ£Όμ */
	gender VARCHAR2(1), /* ?±λ³? */
	birthday VARCHAR2(10), /* ????Ό */
	point NUMBER DEFAULT 0, /* ? λ¦½κΈ */
	registerday DATE DEFAULT sysdate, /* κ°???Ό? */
	lastpwdchangedate DATE DEFAULT sysdate, /* λ§μ?λ§μ?Έλ³?κ²½λ μ§μκ°? */
	register_status NUMBER(1) DEFAULT 1 NOT NULL, /* ????΄?¬λΆ? */
	inactive_status NUMBER(1) DEFAULT 0 NOT NULL, /* ?΄λ©΄μ¬λΆ? */
	sms_status NUMBER(1) NOT NULL, /* SMS?? ???¬λΆ? */
	email_status NUMBER(1) NOT NULL /* ?΄λ©μΌ?? ???¬λΆ? */
);

CREATE UNIQUE INDEX PK_tbl_member
	ON tbl_member (
		userid ASC
	);

CREATE UNIQUE INDEX UIX_tbl_member
	ON tbl_member (
		email ASC
	);

ALTER TABLE tbl_member
	ADD
		CONSTRAINT PK_tbl_member
		PRIMARY KEY (
			userid
		);

ALTER TABLE tbl_member
	ADD
		CONSTRAINT UK_tbl_member
		UNIQUE (
			email
		);

ALTER TABLE tbl_member
	ADD
		CONSTRAINT CK_tbl_member
		CHECK (register_status in(0,1));

ALTER TABLE tbl_member
	ADD
		CONSTRAINT CK_tbl_member_gender
		CHECK (gender in('1','2'));

ALTER TABLE tbl_member
	ADD
		CONSTRAINT CK_tbl_member_status
		CHECK (register_status in(0,1));

ALTER TABLE tbl_member
	ADD
		CONSTRAINT CK_tbl_member_sms_status
		CHECK (sms_status in(0,1));

ALTER TABLE tbl_member
	ADD
		CONSTRAINT CK_tbl_member_email_status
		CHECK (email_status in(0,1));

/* ?κΈ°μ’?? */
CREATE TABLE tbl_review_like (
	fk_review_no NUMBER NOT NULL, /* ?κΈ°λ²?Έ */
	fk_userid VARCHAR2(20) NOT NULL /* ????΄? */
);

CREATE UNIQUE INDEX PK_tbl_review_like
	ON tbl_review_like (
		fk_review_no ASC,
		fk_userid ASC
	);

ALTER TABLE tbl_review_like
	ADD
		CONSTRAINT PK_tbl_review_like
		PRIMARY KEY (
			fk_review_no,
			fk_userid
		);

/* μ£Όλ¬Έ??Έ */
CREATE TABLE tbl_orderdetail (
	orderseqnum NUMBER NOT NULL, /* μ£Όλ¬Έ??Έ?Ό? ¨λ²νΈ */
	fk_productnum NUMBER(8) NOT NULL, /* ? ?λ²νΈ */
	ordernum VARCHAR2(20) NOT NULL, /* μ£Όλ¬Έμ½λ */
	orderqty NUMBER NOT NULL, /* μ£Όλ¬Έ? */
	orderprice NUMBER NOT NULL, /* μ£Όλ¬Έκ°?κ²? */
	deliverstatus NUMBER(1) DEFAULT 1 NOT NULL, /* λ°°μ‘?? */
	deliverdate DATE /* λ°°μ‘?λ£μΌ? */
);

CREATE UNIQUE INDEX PK_tbl_orderdetail
	ON tbl_orderdetail (
		orderseqnum ASC
	);

ALTER TABLE tbl_orderdetail
	ADD
		CONSTRAINT PK_tbl_orderdetail
		PRIMARY KEY (
			orderseqnum
		);

/* μ£Όλ¬Έ */
CREATE TABLE tbl_order (
	ordernum VARCHAR2(20) NOT NULL, /* μ£Όλ¬Έμ½λ */
	fk_userid VARCHAR2(20) NOT NULL, /* ????΄?(μ£Όλ¬Έ???λΆ?) */
	ordertotalprice NUMBER NOT NULL, /* μ£Όλ¬Έμ΄μ‘ */
	ordertotalpoint NUMBER(8) NOT NULL, /* μ£Όλ¬Έμ΄ν¬?Έ?Έ */
	orderdate DATE DEFAULT sysdate NOT NULL, /* μ£Όλ¬Έ?Ό? */
	paymethod NUMBER(1), /* κ²°μ ??¨ */
	name_receiver VARCHAR2(30), /* λ°μΌ??λΆ? */
	zipcode VARCHAR2(100), /* ?°?Έλ²νΈ */
	address VARCHAR2(200) /* λ°°μ‘μ§?μ£Όμ */
);

CREATE UNIQUE INDEX PK_tbl_order
	ON tbl_order (
		ordernum ASC
	);

ALTER TABLE tbl_order
	ADD
		CONSTRAINT PK_tbl_order
		PRIMARY KEY (
			ordernum
		);

ALTER TABLE tbl_product
	ADD
		CONSTRAINT FK_tbl_category_TO_tbl_product
		FOREIGN KEY (
			categorynum
		)
		REFERENCES tbl_category (
			categorynum
		);

ALTER TABLE tbl_product
	ADD
		CONSTRAINT FK_tbl_spec_TO_tbl_product
		FOREIGN KEY (
			fk_specnum
		)
		REFERENCES tbl_spec (
			specnum
		);

ALTER TABLE tbl_product_imagefile
	ADD
		CONSTRAINT FK_tbl_product_TO_tbl_pimg
		FOREIGN KEY (
			fk_productnum
		)
		REFERENCES tbl_product (
			productnum
		);

ALTER TABLE tbl_cart
	ADD
		CONSTRAINT FK_tbl_product_TO_tbl_cart
		FOREIGN KEY (
			fk_productnum
		)
		REFERENCES tbl_product (
			productnum
		);

ALTER TABLE tbl_cart
	ADD
		CONSTRAINT FK_tbl_member_TO_tbl_cart
		FOREIGN KEY (
			fk_userid
		)
		REFERENCES tbl_member (
			userid
		);

ALTER TABLE tbl_dibs
	ADD
		CONSTRAINT FK_tbl_product_TO_tbl_dibs
		FOREIGN KEY (
			fk_productnum
		)
		REFERENCES tbl_product (
			productnum
		);

ALTER TABLE tbl_dibs
	ADD
		CONSTRAINT FK_tbl_member_TO_tbl_dibs
		FOREIGN KEY (
			fk_userid
		)
		REFERENCES tbl_member (
			userid
		);

ALTER TABLE tbl_notice
	ADD
		CONSTRAINT FK_tbl_member_TO_tbl_notice
		FOREIGN KEY (
			fk_userid
		)
		REFERENCES tbl_member (
			userid
		);

ALTER TABLE tbl_event
	ADD
		CONSTRAINT FK_tbl_member_TO_tbl_event
		FOREIGN KEY (
			userid
		)
		REFERENCES tbl_member (
			userid
		);

ALTER TABLE tbl_purchase_reviews
	ADD
		CONSTRAINT FK_tbl_member_TO_tbl_reviews
		FOREIGN KEY (
			fk_userid
		)
		REFERENCES tbl_member (
			userid
		);

ALTER TABLE tbl_purchase_reviews
	ADD
		CONSTRAINT FK_tbl_product_TO_tbl_reviews
		FOREIGN KEY (
			fk_productnum
		)
		REFERENCES tbl_product (
			productnum
		);

ALTER TABLE tbl_faq
	ADD
		CONSTRAINT FK_tbl_member_TO_tbl_faq
		FOREIGN KEY (
			fk_userid
		)
		REFERENCES tbl_member (
			userid
		);

ALTER TABLE tbl_qna
	ADD
		CONSTRAINT FK_tbl_member_TO_tbl_qna
		FOREIGN KEY (
			fk_userid
		)
		REFERENCES tbl_member (
			userid
		);

ALTER TABLE tbl_loginhistory
	ADD
		CONSTRAINT FK_tbl_member_TO_tbl_loghis
		FOREIGN KEY (
			fk_userid
		)
		REFERENCES tbl_member (
			userid
		);

ALTER TABLE tbl_review_like
	ADD
		CONSTRAINT FK_tbl_reviews_TO_tbl_rev_like
		FOREIGN KEY (
			fk_review_no
		)
		REFERENCES tbl_purchase_reviews (
			review_no
		);

ALTER TABLE tbl_review_like
	ADD
		CONSTRAINT FK_tbl_member_TO_tbl_rev_like
		FOREIGN KEY (
			fk_userid
		)
		REFERENCES tbl_member (
			userid
		);

ALTER TABLE tbl_orderdetail
	ADD
		CONSTRAINT FK_tbl_prod_TO_tbl_orddetail
		FOREIGN KEY (
			fk_productnum
		)
		REFERENCES tbl_product (
			productnum
		);

ALTER TABLE tbl_orderdetail
	ADD
		CONSTRAINT FK_tbl_order_TO_tbl_orddetail
		FOREIGN KEY (
			ordernum
		)
		REFERENCES tbl_order (
			ordernum
		);

ALTER TABLE tbl_order
	ADD
		CONSTRAINT FK_tbl_member_TO_tbl_order
		FOREIGN KEY (
			fk_userid
		)
		REFERENCES tbl_member (
			userid
		);
        
        
------------????€ ??± ??-------

/* FAQ ????€ ??± */
     create sequence seq_faqno   
     start with 1    
     increment by 1  
     nomaxvalue     
     nocycle         
     nocache;

/* κ³΅μ??¬?­ ????€ ??± */
create sequence seq_noticeno   
     start with 1    
     increment by 1  
     nomaxvalue     
     nocycle         
     nocache;

/* ?΄λ²€νΈ ????€ ??± */
create sequence seq_eventno    
     start with 1    
     increment by 1  
     nomaxvalue     
     nocycle         
     nocache;

/* QNA  ????€ ??± */
create sequence seq_qnano 
     start with 1    
     increment by 1  
     nomaxvalue     
     nocycle         
     nocache;

/* ? ?κ΅¬λ§€?κΈ°λ¦¬λ·? ????€ ??± */
create sequence seq_review_no  
     start with 1    
     increment by 1  
     nomaxvalue     
     nocycle         
     nocache;

/* ?₯λ°κ΅¬? ????€ ??± */
create sequence seq_cartno  
     start with 1    
     increment by 1  
     nomaxvalue     
     nocycle         
     nocache;

------------????€ ??± ?-------

select *
  from user_sequences;