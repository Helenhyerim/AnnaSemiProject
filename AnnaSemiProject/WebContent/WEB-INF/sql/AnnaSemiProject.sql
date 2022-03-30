<<<<<<< HEAD

/* 제품 */
CREATE TABLE tbl_product (
	productnum NUMBER(8) NOT NULL, /* 제품번호 */
	categorynum NUMBER(8) NOT NULL, /* 카테고리대분류번호 */
	productname VARCHAR2(100) NOT NULL, /* 제품명 */
	productcompany VARCHAR2(50), /* 제조회사명 */
	productimage1 VARCHAR2(100), /* 대표제품이미지1 */
	productimage2 VARCHAR2(100), /* 대표제품이미지2 */
	productqty NUMBER(8) DEFAULT 0, /* 제품재고량 */
	productprice NUMBER(8) DEFAULT 0, /* 제품정가 */
	saleprice NUMBER(8) DEFAULT 0, /* 제품판매가 */
	fk_specnum NUMBER(8), /* 스펙번호 */
	productcontent VARCHAR2(4000), /* 제품설명 */
	point NUMBER(8) DEFAULT 0, /* 적립금 */
	productinputdate DATE DEFAULT sysdate /* 제품입고일자 */
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

/* 제품추가이미지 */
CREATE TABLE tbl_product_imagefile (
	imagefilenum NUMBER NOT NULL, /* 이미지번호 */
	fk_productnum NUMBER(8) NOT NULL, /* 제품번호 */
	imagefilename VARCHAR2(100) NOT NULL /* 이미지파일명 */
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
	categorynum NUMBER(8) NOT NULL, /* 카테고리대분류번호 */
	code VARCHAR2(20) NOT NULL, /* 카테고리코드 */
	categoryname VARCHAR2(100) NOT NULL /* 카테고리명 */
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

/* 제품스펙 */
CREATE TABLE tbl_spec (
	specnum NUMBER(8) NOT NULL, /* 스펙번호 */
	specname VARCHAR2(100) NOT NULL /* 스펙명 */
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

/* 장바구니 */
CREATE TABLE tbl_cart (
	cartno NUMBER NOT NULL, /* 장바구니번호 */
	fk_userid VARCHAR2(20) NOT NULL, /* 회원아이디 */
	fk_productnum NUMBER(8) NOT NULL, /* 제품번호 */
	orderqty NUMBER(4) DEFAULT 0, /* 주문량 */
	registerday DATE DEFAULT sysdate /* 입력일자 */
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

/* 찜하기 */
CREATE TABLE tbl_dibs (
	fk_productnum NUMBER(8) NOT NULL, /* 제품번호 */
	fk_userid VARCHAR2(20) NOT NULL /* 회원아이디 */
);

/* 공지사항 */
CREATE TABLE tbl_notice (
	noticeno NUMBER NOT NULL, /* 공지사항번호 */
	fk_userid VARCHAR2(20) NOT NULL, /* 회원아이디 */
	noticedate DATE DEFAULT sysdate NOT NULL, /* 작성일자 */
	noticetitle VARCHAR2(100) NOT NULL, /* 글제목 */
	noticecontents VARCHAR2(4000) NOT NULL /* 글내용 */
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

/* 이벤트 */
CREATE TABLE tbl_event (
	eventno NUMBER NOT NULL, /* 이벤트번호 */
	userid VARCHAR2(20) NOT NULL, /* 회원아이디 */
	eventdate DATE DEFAULT sysdate NOT NULL, /* 작성일자 */
	eventtitle VARCHAR2(100) NOT NULL, /* 글제목 */
	eventcontents VARCHAR2(4000) NOT NULL, /* 글내용 */
	imagefilename VARCHAR2(100), /* 이미지 */
	eventstartdate DATE NOT NULL, /* 이벤트시작일 */
	eventenddate DATE /* 이벤트종료일 */
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

/* 제품구매후기리뷰 */
CREATE TABLE tbl_purchase_reviews (
	review_no NUMBER NOT NULL, /* 작성번호 */
	fk_userid VARCHAR2(20) NOT NULL, /* 회원아이디 */
	fk_productnum NUMBER(8) NOT NULL, /* 제품번호 */
	reviewcontents VARCHAR2(4000) NOT NULL, /* 리뷰내용 */
	reviewdate DATE DEFAULT sysdate /* 작성일자 */
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
	fk_userid VARCHAR2(20) NOT NULL, /* 회원아이디 */
	faqrequesttype VARCHAR2(20) NOT NULL, /* 문의분류 */
	faqtitle VARCHAR2(100) NOT NULL, /* 글제목 */
	faqcontents VARCHAR2(4000) NOT NULL /* 글내용 */
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
	fk_userid VARCHAR2(20) NOT NULL, /* 회원아이디 */
	questiontitle VARCHAR2(100) NOT NULL, /* 질문제목 */
	questioncontents VARCHAR2(4000) NOT NULL, /* 질문내용 */
	questiondate DATE DEFAULT sysdate NOT NULL, /* 질문작성일자 */
	answertitle VARCHAR2(100), /* 답변제목 */
	answercontents VARCHAR2(4000), /* 답변내용 */
	answerdate DATE DEFAULT sysdate /* 답변작성일자 */
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

/* 로그인기록 */
CREATE TABLE tbl_loginhistory (
	fk_userid VARCHAR2(20), /* 회원아이디 */
	logindate DATE DEFAULT sysdate NOT NULL, /* 로그인날짜시각 */
	clientip VARCHAR2(20) /* 접속IP주소 */
);

/* 회원 */
CREATE TABLE tbl_member (
	userid VARCHAR2(20) NOT NULL, /* 회원아이디 */
	pwd VARCHAR2(200) NOT NULL, /* 회원비밀번호 */
	name VARCHAR2(30) NOT NULL, /* 회원명 */
	email VARCHAR2(200) NOT NULL, /* 이메일 */
	mobile VARCHAR2(200), /* 휴대폰번호 */
	postcode VARCHAR2(10), /* 우편번호 */
	address VARCHAR2(200), /* 주소 */
	detailaddress VARCHAR2(200), /* 상세주소 */
	gender VARCHAR2(1), /* 성별 */
	birthday VARCHAR2(10), /* 생년월일 */
	point NUMBER DEFAULT 0, /* 적립금 */
	registerday DATE DEFAULT sysdate, /* 가입일자 */
	lastpwdchangedate DATE DEFAULT sysdate, /* 마지막암호변경날짜시각 */
	register_status NUMBER(1) DEFAULT 1 NOT NULL, /* 회원탈퇴여부 */
	inactive_status NUMBER(1) DEFAULT 0 NOT NULL, /* 휴면여부 */
	sms_status NUMBER(1) NOT NULL, /* SMS수신동의여부 */
	email_status NUMBER(1) NOT NULL /* 이메일수신동의여부 */
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

/* 후기좋아요 */
CREATE TABLE tbl_review_like (
	fk_review_no NUMBER NOT NULL, /* 후기번호 */
	fk_userid VARCHAR2(20) NOT NULL /* 회원아이디 */
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

/* 주문상세 */
CREATE TABLE tbl_orderdetail (
	orderseqnum NUMBER NOT NULL, /* 주문상세일련번호 */
	fk_productnum NUMBER(8) NOT NULL, /* 제품번호 */
	ordernum VARCHAR2(20) NOT NULL, /* 주문코드 */
	orderqty NUMBER NOT NULL, /* 주문량 */
	orderprice NUMBER NOT NULL, /* 주문가격 */
	deliverstatus NUMBER(1) DEFAULT 1 NOT NULL, /* 배송상태 */
	deliverdate DATE /* 배송완료일자 */
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
	fk_userid VARCHAR2(20) NOT NULL, /* 회원아이디(주문하시는분) */
	ordertotalprice NUMBER NOT NULL, /* 주문총액 */
	ordertotalpoint NUMBER(8) NOT NULL, /* 주문총포인트 */
	orderdate DATE DEFAULT sysdate NOT NULL, /* 주문일자 */
	paymethod NUMBER(1), /* 결제수단 */
	name_receiver VARCHAR2(30), /* 받으시는분 */
	zipcode VARCHAR2(100), /* 우편번호 */
	address VARCHAR2(200) /* 배송지주소 */
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

------------시퀀스 생성 시작-------

/* FAQ 시퀀스 생성 */
     create sequence seq_faqno   
     start with 1    
     increment by 1  
     nomaxvalue     
     nocycle         
     nocache;

/* 공지사항 시퀀스 생성 */
create sequence seq_noticeno   
     start with 1    
     increment by 1  
     nomaxvalue     
     nocycle         
     nocache;

/* 이벤트 시퀀스 생성 */
create sequence seq_eventno    
     start with 1    
     increment by 1  
     nomaxvalue     
     nocycle         
     nocache;

/* QNA  시퀀스 생성 */
create sequence seq_qnano 
     start with 1    
     increment by 1  
     nomaxvalue     
     nocycle         
     nocache;

/* 제품구매후기리뷰 시퀀스 생성 */
create sequence seq_review_no  
     start with 1    
     increment by 1  
     nomaxvalue     
     nocycle         
     nocache;

/* 장바구니 시퀀스 생성 */
create sequence seq_cartno  
     start with 1    
     increment by 1  
     nomaxvalue     
     nocycle         
     nocache;



------------시퀀스 생성 끝-------

  
  
  
=======
show user;

select * from tab;

select *
  from user_sequences;
  
select *
from tbl_member
order by registerday desc;

delete from tbl_member
where userid='simyj';

commit;
>>>>>>> branch 'member_branch' of https://github.com/Helenhyerim/AnnaSemiProject.git
