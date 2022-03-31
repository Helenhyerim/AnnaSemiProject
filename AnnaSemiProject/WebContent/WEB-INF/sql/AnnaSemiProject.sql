show user;
-- USER?��(�?) "SEMIORAUSER2"?��?��?��.

grant connect, resource, create view, unlimited tablespace to SEMIORAUSER2;

select * from anna_test;

select * 
from tab;



------------------------

/* ?��?�� */
CREATE TABLE tbl_product (
	productnum NUMBER(8) NOT NULL, /* ?��?��번호 */
	categorynum NUMBER(8) NOT NULL, /* 카테고리??분류번호 */
	productname VARCHAR2(100) NOT NULL, /* ?��?���? */
	productcompany VARCHAR2(50), /* ?��조회?���? */
	productimage1 VARCHAR2(100), /* ???��?��?��?��미�?1 */
	productimage2 VARCHAR2(100), /* ???��?��?��?��미�?2 */
	productqty NUMBER(8) DEFAULT 0, /* ?��?��?��고량 */
	productprice NUMBER(8) DEFAULT 0, /* ?��?��?���? */
	saleprice NUMBER(8) DEFAULT 0, /* ?��?��?��매�? */
	fk_specnum NUMBER(8), /* ?��?��번호 */
	productcontent VARCHAR2(4000), /* ?��?��?���? */
	point NUMBER(8) DEFAULT 0, /* ?��립금 */
	productinputdate DATE DEFAULT sysdate /* ?��?��?��고일?�� */
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

/* ?��?��추�??��미�? */
CREATE TABLE tbl_product_imagefile (
	imagefilenum NUMBER NOT NULL, /* ?��미�?번호 */
	fk_productnum NUMBER(8) NOT NULL, /* ?��?��번호 */
	imagefilename VARCHAR2(100) NOT NULL /* ?��미�??��?���? */
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

/* 카테고리 */
CREATE TABLE tbl_category (
	categorynum NUMBER(8) NOT NULL, /* 카테고리??분류번호 */
	code VARCHAR2(20) NOT NULL, /* 카테고리코드 */
	categoryname VARCHAR2(100) NOT NULL /* 카테고리�? */
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

/* ?��?��?��?�� */
CREATE TABLE tbl_spec (
	specnum NUMBER(8) NOT NULL, /* ?��?��번호 */
	specname VARCHAR2(100) NOT NULL /* ?��?���? */
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

/* ?��바구?�� */
CREATE TABLE tbl_cart (
	cartno NUMBER NOT NULL, /* ?��바구?��번호 */
	fk_userid VARCHAR2(20) NOT NULL, /* ?��?��?��?��?�� */
	fk_productnum NUMBER(8) NOT NULL, /* ?��?��번호 */
	orderqty NUMBER(4) DEFAULT 0, /* 주문?�� */
	registerday DATE DEFAULT sysdate /* ?��?��?��?�� */
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

/* 찜하�? */
CREATE TABLE tbl_dibs (
	fk_productnum NUMBER(8) NOT NULL, /* ?��?��번호 */
	fk_userid VARCHAR2(20) NOT NULL /* ?��?��?��?��?�� */
);

/* 공�??��?�� */
CREATE TABLE tbl_notice (
	noticeno NUMBER NOT NULL, /* 공�??��?��번호 */
	fk_userid VARCHAR2(20) NOT NULL, /* ?��?��?��?��?�� */
	noticedate DATE DEFAULT sysdate NOT NULL, /* ?��?��?��?�� */
	noticetitle VARCHAR2(100) NOT NULL, /* �??���? */
	noticecontents VARCHAR2(4000) NOT NULL /* �??��?�� */
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

/* ?��벤트 */
CREATE TABLE tbl_event (
	eventno NUMBER NOT NULL, /* ?��벤트번호 */
	userid VARCHAR2(20) NOT NULL, /* ?��?��?��?��?�� */
	eventdate DATE DEFAULT sysdate NOT NULL, /* ?��?��?��?�� */
	eventtitle VARCHAR2(100) NOT NULL, /* �??���? */
	eventcontents VARCHAR2(4000) NOT NULL, /* �??��?�� */
	imagefilename VARCHAR2(100), /* ?��미�? */
	eventstartdate DATE NOT NULL, /* ?��벤트?��?��?�� */
	eventenddate DATE /* ?��벤트종료?�� */
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

/* ?��?��구매?��기리�? */
CREATE TABLE tbl_purchase_reviews (
	review_no NUMBER NOT NULL, /* ?��?��번호 */
	fk_userid VARCHAR2(20) NOT NULL, /* ?��?��?��?��?�� */
	fk_productnum NUMBER(8) NOT NULL, /* ?��?��번호 */
	reviewcontents VARCHAR2(4000) NOT NULL, /* 리뷰?��?�� */
	reviewdate DATE DEFAULT sysdate /* ?��?��?��?�� */
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
	faqno NUMBER NOT NULL, /* FAQ번호 */
	fk_userid VARCHAR2(20) NOT NULL, /* ?��?��?��?��?�� */
	faqrequesttype VARCHAR2(20) NOT NULL, /* 문의분류 */
	faqtitle VARCHAR2(100) NOT NULL, /* �??���? */
	faqcontents VARCHAR2(4000) NOT NULL /* �??��?�� */
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
	qnano NUMBER NOT NULL, /* QnA번호 */
	fk_userid VARCHAR2(20) NOT NULL, /* ?��?��?��?��?�� */
	questiontitle VARCHAR2(100) NOT NULL, /* 질문?���? */
	questioncontents VARCHAR2(4000) NOT NULL, /* 질문?��?�� */
	questiondate DATE DEFAULT sysdate NOT NULL, /* 질문?��?��?��?�� */
	answertitle VARCHAR2(100), /* ?���??���? */
	answercontents VARCHAR2(4000), /* ?���??��?�� */
	answerdate DATE DEFAULT sysdate /* ?���??��?��?��?�� */
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

/* 로그?��기록 */
CREATE TABLE tbl_loginhistory (
	fk_userid VARCHAR2(20), /* ?��?��?��?��?�� */
	logindate DATE DEFAULT sysdate NOT NULL, /* 로그?��?��짜시�? */
	clientip VARCHAR2(20) /* ?��?��IP주소 */
);

/* ?��?�� */
CREATE TABLE tbl_member (
	userid VARCHAR2(20) NOT NULL, /* ?��?��?��?��?�� */
	pwd VARCHAR2(200) NOT NULL, /* ?��?��비�?번호 */
	name VARCHAR2(30) NOT NULL, /* ?��?���? */
	email VARCHAR2(200) NOT NULL, /* ?��메일 */
	mobile VARCHAR2(200), /* ?��???��번호 */
	postcode VARCHAR2(10), /* ?��?��번호 */
	address VARCHAR2(200), /* 주소 */
	detailaddress VARCHAR2(200), /* ?��?��주소 */
	gender VARCHAR2(1), /* ?���? */
	birthday VARCHAR2(10), /* ?��?��?��?�� */
	point NUMBER DEFAULT 0, /* ?��립금 */
	registerday DATE DEFAULT sysdate, /* �??��?��?�� */
	lastpwdchangedate DATE DEFAULT sysdate, /* 마�?막암?���?경날짜시�? */
	register_status NUMBER(1) DEFAULT 1 NOT NULL, /* ?��?��?��?��?���? */
	inactive_status NUMBER(1) DEFAULT 0 NOT NULL, /* ?��면여�? */
	sms_status NUMBER(1) NOT NULL, /* SMS?��?��?��?��?���? */
	email_status NUMBER(1) NOT NULL /* ?��메일?��?��?��?��?���? */
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

/* ?��기좋?��?�� */
CREATE TABLE tbl_review_like (
	fk_review_no NUMBER NOT NULL, /* ?��기번?�� */
	fk_userid VARCHAR2(20) NOT NULL /* ?��?��?��?��?�� */
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

/* 주문?��?�� */
CREATE TABLE tbl_orderdetail (
	orderseqnum NUMBER NOT NULL, /* 주문?��?��?��?��번호 */
	fk_productnum NUMBER(8) NOT NULL, /* ?��?��번호 */
	ordernum VARCHAR2(20) NOT NULL, /* 주문코드 */
	orderqty NUMBER NOT NULL, /* 주문?�� */
	orderprice NUMBER NOT NULL, /* 주문�?�? */
	deliverstatus NUMBER(1) DEFAULT 1 NOT NULL, /* 배송?��?�� */
	deliverdate DATE /* 배송?��료일?�� */
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

/* 주문 */
CREATE TABLE tbl_order (
	ordernum VARCHAR2(20) NOT NULL, /* 주문코드 */
	fk_userid VARCHAR2(20) NOT NULL, /* ?��?��?��?��?��(주문?��?��?���?) */
	ordertotalprice NUMBER NOT NULL, /* 주문총액 */
	ordertotalpoint NUMBER(8) NOT NULL, /* 주문총포?��?�� */
	orderdate DATE DEFAULT sysdate NOT NULL, /* 주문?��?�� */
	paymethod NUMBER(1), /* 결제?��?�� */
	name_receiver VARCHAR2(30), /* 받으?��?���? */
	zipcode VARCHAR2(100), /* ?��?��번호 */
	address VARCHAR2(200) /* 배송�?주소 */
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
        
        
------------?��???�� ?��?�� ?��?��-------

/* FAQ ?��???�� ?��?�� */
     create sequence seq_faqno   
     start with 1    
     increment by 1  
     nomaxvalue     
     nocycle         
     nocache;

/* 공�??��?�� ?��???�� ?��?�� */
create sequence seq_noticeno   
     start with 1    
     increment by 1  
     nomaxvalue     
     nocycle         
     nocache;

/* ?��벤트 ?��???�� ?��?�� */
create sequence seq_eventno    
     start with 1    
     increment by 1  
     nomaxvalue     
     nocycle         
     nocache;

/* QNA  ?��???�� ?��?�� */
create sequence seq_qnano 
     start with 1    
     increment by 1  
     nomaxvalue     
     nocycle         
     nocache;

/* ?��?��구매?��기리�? ?��???�� ?��?�� */
create sequence seq_review_no  
     start with 1    
     increment by 1  
     nomaxvalue     
     nocycle         
     nocache;

/* ?��바구?�� ?��???�� ?��?�� */
create sequence seq_cartno  
     start with 1    
     increment by 1  
     nomaxvalue     
     nocycle         
     nocache;

------------?��???�� ?��?�� ?��-------

select *
  from user_sequences;