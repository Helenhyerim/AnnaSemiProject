show user;
-- USER이(가) "SEMIORAUSER2"입니다.

<<<<<<< HEAD
grant connect, resource, create view, unlimited tablespace to SEMIORAUSER2;



select * 
from tab;

select * 
from TBL_PRODUCT;

desc tbl_product;

select * 
from TBL_CATEGORY;

desc TBL_CATEGORY;

select * 
from TBL_spec;

desc TBL_spec;

insert into TBL_CATEGORY(CATEGORYNUM,CODE,CATEGORYNAME) values (1, 'code-01','紐⑷구�씠');
insert into TBL_CATEGORY(CATEGORYNUM,CODE,CATEGORYNAME) values (2, 'code-02','洹�嫄몄씠');
insert into TBL_CATEGORY(CATEGORYNUM,CODE,CATEGORYNAME) values (3, 'code-03','諛섏��');
insert into TBL_CATEGORY(CATEGORYNUM,CODE,CATEGORYNAME) values (4, 'code-04','�뙏李�');
commit;

insert into tbl_spec(SPECNUM,SPECNAME) values(1, '�씪諛섏긽�뭹');
commit;
-----tbl_product �뿉 �꽔�쓣 �젣�뭹�뱾 �봽濡쒖떆��� �깮�꽦-------------------------

insert into tbl_product(PRODUCTNUM,CATEGORYNUM,PRODUCTNAME,PRODUCTIMAGE1,PRODUCTIMAGE2,PRODUCTQTY,PRODUCTPRICE,SALEPRICE,FK_SPECNUM,PRODUCTINPUTDATE)
values(1, 3, '諛섏��1', 'p1.png', 'p2.png', 20, 345000, 334650, 1, sysdate);

insert into tbl_product(PRODUCTNUM,CATEGORYNUM,PRODUCTNAME,PRODUCTIMAGE1,PRODUCTIMAGE2,PRODUCTQTY,PRODUCTPRICE,SALEPRICE,FK_SPECNUM,PRODUCTINPUTDATE)
values(2, 3, '諛섏��2', 'p1.png', 'p2.png', 20, 345000, 334650, 1, sysdate);

insert into tbl_product(PRODUCTNUM,CATEGORYNUM,PRODUCTNAME,PRODUCTIMAGE1,PRODUCTIMAGE2,PRODUCTQTY,PRODUCTPRICE,SALEPRICE,FK_SPECNUM,PRODUCTINPUTDATE)
values(3, 3, '諛섏��3', 'p1.png', 'p2.png', 20, 345000, 334650, 1, sysdate);

insert into tbl_product(PRODUCTNUM,CATEGORYNUM,PRODUCTNAME,PRODUCTIMAGE1,PRODUCTIMAGE2,PRODUCTQTY,PRODUCTPRICE,SALEPRICE,FK_SPECNUM,PRODUCTINPUTDATE)
values(4, 3, '諛섏��4', 'p1.png', 'p2.png', 20, 345000, 334650, 1, sysdate);

insert into tbl_product(PRODUCTNUM,CATEGORYNUM,PRODUCTNAME,PRODUCTIMAGE1,PRODUCTIMAGE2,PRODUCTQTY,PRODUCTPRICE,SALEPRICE,FK_SPECNUM,PRODUCTINPUTDATE)
values(5, 3, '諛섏��5', 'p1.png', 'p2.png', 20, 345000, 334650, 1, sysdate);
commit;
------------------------

/* �젣�뭹 */
CREATE TABLE tbl_product (
	productnum NUMBER(8) NOT NULL, /* �젣�뭹踰덊샇 */
	categorynum NUMBER(8) NOT NULL, /* 移댄뀒怨좊━���遺꾨쪟踰덊샇 */
	productname VARCHAR2(100) NOT NULL, /* �젣�뭹紐� */
	productcompany VARCHAR2(50), /* �젣議고쉶�궗紐� */
	productimage1 VARCHAR2(100), /* ����몴�젣�뭹�씠誘몄��1 */
	productimage2 VARCHAR2(100), /* ����몴�젣�뭹�씠誘몄��2 */
	productqty NUMBER(8) DEFAULT 0, /* �젣�뭹�옱怨좊웾 */
	productprice NUMBER(8) DEFAULT 0, /* �젣�뭹�젙媛� */
	saleprice NUMBER(8) DEFAULT 0, /* �젣�뭹�뙋留ㅺ�� */
	fk_specnum NUMBER(8), /* �뒪�럺踰덊샇 */
	productcontent VARCHAR2(4000), /* �젣�뭹�꽕紐� */
	point NUMBER(8) DEFAULT 0, /* �쟻由쎄툑 */
	productinputdate DATE DEFAULT sysdate /* �젣�뭹�엯怨좎씪�옄 */
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

/* �젣�뭹異붽���씠誘몄�� */
CREATE TABLE tbl_product_imagefile (
	imagefilenum NUMBER NOT NULL, /* �씠誘몄��踰덊샇 */
	fk_productnum NUMBER(8) NOT NULL, /* �젣�뭹踰덊샇 */
	imagefilename VARCHAR2(100) NOT NULL /* �씠誘몄���뙆�씪紐� */
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

/* 移댄뀒怨좊━ */
CREATE TABLE tbl_category (
	categorynum NUMBER(8) NOT NULL, /* 移댄뀒怨좊━���遺꾨쪟踰덊샇 */
	code VARCHAR2(20) NOT NULL, /* 移댄뀒怨좊━肄붾뱶 */
	categoryname VARCHAR2(100) NOT NULL /* 移댄뀒怨좊━紐� */
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

/* �젣�뭹�뒪�럺 */
CREATE TABLE tbl_spec (
	specnum NUMBER(8) NOT NULL, /* �뒪�럺踰덊샇 */
	specname VARCHAR2(100) NOT NULL /* �뒪�럺紐� */
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

/* �옣諛붽뎄�땲 */
CREATE TABLE tbl_cart (
	cartno NUMBER NOT NULL, /* �옣諛붽뎄�땲踰덊샇 */
	fk_userid VARCHAR2(20) NOT NULL, /* �쉶�썝�븘�씠�뵒 */
	fk_productnum NUMBER(8) NOT NULL, /* �젣�뭹踰덊샇 */
	orderqty NUMBER(4) DEFAULT 0, /* 二쇰Ц�웾 */
	registerday DATE DEFAULT sysdate /* �엯�젰�씪�옄 */
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

/* 李쒗븯湲� */
CREATE TABLE tbl_dibs (
	fk_productnum NUMBER(8) NOT NULL, /* �젣�뭹踰덊샇 */
	fk_userid VARCHAR2(20) NOT NULL /* �쉶�썝�븘�씠�뵒 */
);

/* 怨듭���궗�빆 */
CREATE TABLE tbl_notice (
	noticeno NUMBER NOT NULL, /* 怨듭���궗�빆踰덊샇 */
	fk_userid VARCHAR2(20) NOT NULL, /* �쉶�썝�븘�씠�뵒 */
	noticedate DATE DEFAULT sysdate NOT NULL, /* �옉�꽦�씪�옄 */
	noticetitle VARCHAR2(100) NOT NULL, /* 湲��젣紐� */
	noticecontents VARCHAR2(4000) NOT NULL /* 湲��궡�슜 */
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

/* �씠踰ㅽ듃 */
CREATE TABLE tbl_event (
	eventno NUMBER NOT NULL, /* �씠踰ㅽ듃踰덊샇 */
	userid VARCHAR2(20) NOT NULL, /* �쉶�썝�븘�씠�뵒 */
	eventdate DATE DEFAULT sysdate NOT NULL, /* �옉�꽦�씪�옄 */
	eventtitle VARCHAR2(100) NOT NULL, /* 湲��젣紐� */
	eventcontents VARCHAR2(4000) NOT NULL, /* 湲��궡�슜 */
	imagefilename VARCHAR2(100), /* �씠誘몄�� */
	eventstartdate DATE NOT NULL, /* �씠踰ㅽ듃�떆�옉�씪 */
	eventenddate DATE /* �씠踰ㅽ듃醫낅즺�씪 */
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

/* �젣�뭹援щℓ�썑湲곕━酉� */
CREATE TABLE tbl_purchase_reviews (
	review_no NUMBER NOT NULL, /* �옉�꽦踰덊샇 */
	fk_userid VARCHAR2(20) NOT NULL, /* �쉶�썝�븘�씠�뵒 */
	fk_productnum NUMBER(8) NOT NULL, /* �젣�뭹踰덊샇 */
	reviewcontents VARCHAR2(4000) NOT NULL, /* 由щ럭�궡�슜 */
	reviewdate DATE DEFAULT sysdate /* �옉�꽦�씪�옄 */
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
	faqno NUMBER NOT NULL, /* FAQ踰덊샇 */
	fk_userid VARCHAR2(20) NOT NULL, /* �쉶�썝�븘�씠�뵒 */
	faqrequesttype VARCHAR2(20) NOT NULL, /* 臾몄쓽遺꾨쪟 */
	faqtitle VARCHAR2(100) NOT NULL, /* 湲��젣紐� */
	faqcontents VARCHAR2(4000) NOT NULL /* 湲��궡�슜 */
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
	qnano NUMBER NOT NULL, /* QnA踰덊샇 */
	fk_userid VARCHAR2(20) NOT NULL, /* �쉶�썝�븘�씠�뵒 */
	questiontitle VARCHAR2(100) NOT NULL, /* 吏덈Ц�젣紐� */
	questioncontents VARCHAR2(4000) NOT NULL, /* 吏덈Ц�궡�슜 */
	questiondate DATE DEFAULT sysdate NOT NULL, /* 吏덈Ц�옉�꽦�씪�옄 */
	answertitle VARCHAR2(100), /* �떟蹂��젣紐� */
	answercontents VARCHAR2(4000), /* �떟蹂��궡�슜 */
	answerdate DATE DEFAULT sysdate /* �떟蹂��옉�꽦�씪�옄 */
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

/* 濡쒓렇�씤湲곕줉 */
CREATE TABLE tbl_loginhistory (
	fk_userid VARCHAR2(20), /* �쉶�썝�븘�씠�뵒 */
	logindate DATE DEFAULT sysdate NOT NULL, /* 濡쒓렇�씤�궇吏쒖떆媛� */
	clientip VARCHAR2(20) /* �젒�냽IP二쇱냼 */
);

/* �쉶�썝 */
CREATE TABLE tbl_member (
	userid VARCHAR2(20) NOT NULL, /* �쉶�썝�븘�씠�뵒 */
	pwd VARCHAR2(200) NOT NULL, /* �쉶�썝鍮꾨��踰덊샇 */
	name VARCHAR2(30) NOT NULL, /* �쉶�썝紐� */
	email VARCHAR2(200) NOT NULL, /* �씠硫붿씪 */
	mobile VARCHAR2(200), /* �쑕����룿踰덊샇 */
	postcode VARCHAR2(10), /* �슦�렪踰덊샇 */
	address VARCHAR2(200), /* 二쇱냼 */
	detailaddress VARCHAR2(200), /* �긽�꽭二쇱냼 */
	gender VARCHAR2(1), /* �꽦蹂� */
	birthday VARCHAR2(10), /* �깮�뀈�썡�씪 */
	point NUMBER DEFAULT 0, /* �쟻由쎄툑 */
	registerday DATE DEFAULT sysdate, /* 媛��엯�씪�옄 */
	lastpwdchangedate DATE DEFAULT sysdate, /* 留덉��留됱븫�샇蹂�寃쎈궇吏쒖떆媛� */
	register_status NUMBER(1) DEFAULT 1 NOT NULL, /* �쉶�썝�깉�눜�뿬遺� */
	inactive_status NUMBER(1) DEFAULT 0 NOT NULL, /* �쑕硫댁뿬遺� */
	sms_status NUMBER(1) NOT NULL, /* SMS�닔�떊�룞�쓽�뿬遺� */
	email_status NUMBER(1) NOT NULL /* �씠硫붿씪�닔�떊�룞�쓽�뿬遺� */
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

/* �썑湲곗쥕�븘�슂 */
CREATE TABLE tbl_review_like (
	fk_review_no NUMBER NOT NULL, /* �썑湲곕쾲�샇 */
	fk_userid VARCHAR2(20) NOT NULL /* �쉶�썝�븘�씠�뵒 */
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

/* 二쇰Ц�긽�꽭 */
CREATE TABLE tbl_orderdetail (
	orderseqnum NUMBER NOT NULL, /* 二쇰Ц�긽�꽭�씪�젴踰덊샇 */
	fk_productnum NUMBER(8) NOT NULL, /* �젣�뭹踰덊샇 */
	ordernum VARCHAR2(20) NOT NULL, /* 二쇰Ц肄붾뱶 */
	orderqty NUMBER NOT NULL, /* 二쇰Ц�웾 */
	orderprice NUMBER NOT NULL, /* 二쇰Ц媛�寃� */
	deliverstatus NUMBER(1) DEFAULT 1 NOT NULL, /* 諛곗넚�긽�깭 */
	deliverdate DATE /* 諛곗넚�셿猷뚯씪�옄 */
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

/* 二쇰Ц */
CREATE TABLE tbl_order (
	ordernum VARCHAR2(20) NOT NULL, /* 二쇰Ц肄붾뱶 */
	fk_userid VARCHAR2(20) NOT NULL, /* �쉶�썝�븘�씠�뵒(二쇰Ц�븯�떆�뒗遺�) */
	ordertotalprice NUMBER NOT NULL, /* 二쇰Ц珥앹븸 */
	ordertotalpoint NUMBER(8) NOT NULL, /* 二쇰Ц珥앺룷�씤�듃 */
	orderdate DATE DEFAULT sysdate NOT NULL, /* 二쇰Ц�씪�옄 */
	paymethod NUMBER(1), /* 寃곗젣�닔�떒 */
	name_receiver VARCHAR2(30), /* 諛쏆쑝�떆�뒗遺� */
	zipcode VARCHAR2(100), /* �슦�렪踰덊샇 */
	address VARCHAR2(200) /* 諛곗넚吏�二쇱냼 */
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
        
        
------------�떆����뒪 �깮�꽦 �떆�옉-------

/* FAQ �떆����뒪 �깮�꽦 */
     create sequence seq_faqno   
     start with 1    
     increment by 1  
     nomaxvalue     
     nocycle         
     nocache;

/* 怨듭���궗�빆 �떆����뒪 �깮�꽦 */
create sequence seq_noticeno   
     start with 1    
     increment by 1  
     nomaxvalue     
     nocycle         
     nocache;

/* �씠踰ㅽ듃 �떆����뒪 �깮�꽦 */
create sequence seq_eventno    
     start with 1    
     increment by 1  
     nomaxvalue     
     nocycle         
     nocache;

/* QNA  �떆����뒪 �깮�꽦 */
create sequence seq_qnano 
     start with 1    
     increment by 1  
     nomaxvalue     
     nocycle         
     nocache;

/* �젣�뭹援щℓ�썑湲곕━酉� �떆����뒪 �깮�꽦 */
create sequence seq_review_no  
     start with 1    
     increment by 1  
     nomaxvalue     
     nocycle         
     nocache;

/* �옣諛붽뎄�땲 �떆����뒪 �깮�꽦 */
create sequence seq_cartno  
     start with 1    
     increment by 1  
     nomaxvalue     
     nocycle         
     nocache;

------------�떆����뒪 �깮�꽦 �걹-------

select *
  from user_sequences;
=======
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
=======
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
>>>>>>> branch 'main' of https://github.com/Helenhyerim/AnnaSemiProject.git

/* �젣�뭹 */
CREATE TABLE tbl_product (
	productnum NUMBER(8) NOT NULL, /* �젣�뭹踰덊샇 */
	categorynum NUMBER(8) NOT NULL, /* 移댄뀒怨좊━���遺꾨쪟踰덊샇 */
	productname VARCHAR2(100) NOT NULL, /* �젣�뭹紐� */
	productcompany VARCHAR2(50), /* �젣議고쉶�궗紐� */
	productimage1 VARCHAR2(100), /* ����몴�젣�뭹�씠誘몄��1 */
	productimage2 VARCHAR2(100), /* ����몴�젣�뭹�씠誘몄��2 */
	productqty NUMBER(8) DEFAULT 0, /* �젣�뭹�옱怨좊웾 */
	productprice NUMBER(8) DEFAULT 0, /* �젣�뭹�젙媛� */
	saleprice NUMBER(8) DEFAULT 0, /* �젣�뭹�뙋留ㅺ�� */
	fk_specnum NUMBER(8), /* �뒪�럺踰덊샇 */
	productcontent VARCHAR2(4000), /* �젣�뭹�꽕紐� */
	point NUMBER(8) DEFAULT 0, /* �쟻由쎄툑 */
	productinputdate DATE DEFAULT sysdate /* �젣�뭹�엯怨좎씪�옄 */
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

/* �젣�뭹異붽���씠誘몄�� */
CREATE TABLE tbl_product_imagefile (
	imagefilenum NUMBER NOT NULL, /* �씠誘몄��踰덊샇 */
	fk_productnum NUMBER(8) NOT NULL, /* �젣�뭹踰덊샇 */
	imagefilename VARCHAR2(100) NOT NULL /* �씠誘몄���뙆�씪紐� */
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

/* 移댄뀒怨좊━ */
CREATE TABLE tbl_category (
	categorynum NUMBER(8) NOT NULL, /* 移댄뀒怨좊━���遺꾨쪟踰덊샇 */
	code VARCHAR2(20) NOT NULL, /* 移댄뀒怨좊━肄붾뱶 */
	categoryname VARCHAR2(100) NOT NULL /* 移댄뀒怨좊━紐� */
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

/* �젣�뭹�뒪�럺 */
CREATE TABLE tbl_spec (
	specnum NUMBER(8) NOT NULL, /* �뒪�럺踰덊샇 */
	specname VARCHAR2(100) NOT NULL /* �뒪�럺紐� */
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

/* �옣諛붽뎄�땲 */
CREATE TABLE tbl_cart (
	cartno NUMBER NOT NULL, /* �옣諛붽뎄�땲踰덊샇 */
	fk_userid VARCHAR2(20) NOT NULL, /* �쉶�썝�븘�씠�뵒 */
	fk_productnum NUMBER(8) NOT NULL, /* �젣�뭹踰덊샇 */
	orderqty NUMBER(4) DEFAULT 0, /* 二쇰Ц�웾 */
	registerday DATE DEFAULT sysdate /* �엯�젰�씪�옄 */
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

/* 李쒗븯湲� */
CREATE TABLE tbl_dibs (
	fk_productnum NUMBER(8) NOT NULL, /* �젣�뭹踰덊샇 */
	fk_userid VARCHAR2(20) NOT NULL /* �쉶�썝�븘�씠�뵒 */
);

/* 怨듭���궗�빆 */
CREATE TABLE tbl_notice (
	noticeno NUMBER NOT NULL, /* 怨듭���궗�빆踰덊샇 */
	fk_userid VARCHAR2(20) NOT NULL, /* �쉶�썝�븘�씠�뵒 */
	noticedate DATE DEFAULT sysdate NOT NULL, /* �옉�꽦�씪�옄 */
	noticetitle VARCHAR2(100) NOT NULL, /* 湲��젣紐� */
	noticecontents VARCHAR2(4000) NOT NULL /* 湲��궡�슜 */
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

/* �씠踰ㅽ듃 */
CREATE TABLE tbl_event (
	eventno NUMBER NOT NULL, /* �씠踰ㅽ듃踰덊샇 */
	userid VARCHAR2(20) NOT NULL, /* �쉶�썝�븘�씠�뵒 */
	eventdate DATE DEFAULT sysdate NOT NULL, /* �옉�꽦�씪�옄 */
	eventtitle VARCHAR2(100) NOT NULL, /* 湲��젣紐� */
	eventcontents VARCHAR2(4000) NOT NULL, /* 湲��궡�슜 */
	imagefilename VARCHAR2(100), /* �씠誘몄�� */
	eventstartdate DATE NOT NULL, /* �씠踰ㅽ듃�떆�옉�씪 */
	eventenddate DATE /* �씠踰ㅽ듃醫낅즺�씪 */
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

/* �젣�뭹援щℓ�썑湲곕━酉� */
CREATE TABLE tbl_purchase_reviews (
	review_no NUMBER NOT NULL, /* �옉�꽦踰덊샇 */
	fk_userid VARCHAR2(20) NOT NULL, /* �쉶�썝�븘�씠�뵒 */
	fk_productnum NUMBER(8) NOT NULL, /* �젣�뭹踰덊샇 */
	reviewcontents VARCHAR2(4000) NOT NULL, /* 由щ럭�궡�슜 */
	reviewdate DATE DEFAULT sysdate /* �옉�꽦�씪�옄 */
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
	faqno NUMBER NOT NULL, /* FAQ踰덊샇 */
	fk_userid VARCHAR2(20) NOT NULL, /* �쉶�썝�븘�씠�뵒 */
	faqrequesttype VARCHAR2(20) NOT NULL, /* 臾몄쓽遺꾨쪟 */
	faqtitle VARCHAR2(100) NOT NULL, /* 湲��젣紐� */
	faqcontents VARCHAR2(4000) NOT NULL /* 湲��궡�슜 */
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
	qnano NUMBER NOT NULL, /* QnA踰덊샇 */
	fk_userid VARCHAR2(20) NOT NULL, /* �쉶�썝�븘�씠�뵒 */
	questiontitle VARCHAR2(100) NOT NULL, /* 吏덈Ц�젣紐� */
	questioncontents VARCHAR2(4000) NOT NULL, /* 吏덈Ц�궡�슜 */
	questiondate DATE DEFAULT sysdate NOT NULL, /* 吏덈Ц�옉�꽦�씪�옄 */
	answertitle VARCHAR2(100), /* �떟蹂��젣紐� */
	answercontents VARCHAR2(4000), /* �떟蹂��궡�슜 */
	answerdate DATE DEFAULT sysdate /* �떟蹂��옉�꽦�씪�옄 */
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

/* 濡쒓렇�씤湲곕줉 */
CREATE TABLE tbl_loginhistory (
	fk_userid VARCHAR2(20), /* �쉶�썝�븘�씠�뵒 */
	logindate DATE DEFAULT sysdate NOT NULL, /* 濡쒓렇�씤�궇吏쒖떆媛� */
	clientip VARCHAR2(20) /* �젒�냽IP二쇱냼 */
);

/* �쉶�썝 */
CREATE TABLE tbl_member (
	userid VARCHAR2(20) NOT NULL, /* �쉶�썝�븘�씠�뵒 */
	pwd VARCHAR2(200) NOT NULL, /* �쉶�썝鍮꾨��踰덊샇 */
	name VARCHAR2(30) NOT NULL, /* �쉶�썝紐� */
	email VARCHAR2(200) NOT NULL, /* �씠硫붿씪 */
	mobile VARCHAR2(200), /* �쑕����룿踰덊샇 */
	postcode VARCHAR2(10), /* �슦�렪踰덊샇 */
	address VARCHAR2(200), /* 二쇱냼 */
	detailaddress VARCHAR2(200), /* �긽�꽭二쇱냼 */
	gender VARCHAR2(1), /* �꽦蹂� */
	birthday VARCHAR2(10), /* �깮�뀈�썡�씪 */
	point NUMBER DEFAULT 0, /* �쟻由쎄툑 */
	registerday DATE DEFAULT sysdate, /* 媛��엯�씪�옄 */
	lastpwdchangedate DATE DEFAULT sysdate, /* 留덉��留됱븫�샇蹂�寃쎈궇吏쒖떆媛� */
	register_status NUMBER(1) DEFAULT 1 NOT NULL, /* �쉶�썝�깉�눜�뿬遺� */
	inactive_status NUMBER(1) DEFAULT 0 NOT NULL, /* �쑕硫댁뿬遺� */
	sms_status NUMBER(1) NOT NULL, /* SMS�닔�떊�룞�쓽�뿬遺� */
	email_status NUMBER(1) NOT NULL /* �씠硫붿씪�닔�떊�룞�쓽�뿬遺� */
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

/* �썑湲곗쥕�븘�슂 */
CREATE TABLE tbl_review_like (
	fk_review_no NUMBER NOT NULL, /* �썑湲곕쾲�샇 */
	fk_userid VARCHAR2(20) NOT NULL /* �쉶�썝�븘�씠�뵒 */
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

/* 二쇰Ц�긽�꽭 */
CREATE TABLE tbl_orderdetail (
	orderseqnum NUMBER NOT NULL, /* 二쇰Ц�긽�꽭�씪�젴踰덊샇 */
	fk_productnum NUMBER(8) NOT NULL, /* �젣�뭹踰덊샇 */
	ordernum VARCHAR2(20) NOT NULL, /* 二쇰Ц肄붾뱶 */
	orderqty NUMBER NOT NULL, /* 二쇰Ц�웾 */
	orderprice NUMBER NOT NULL, /* 二쇰Ц媛�寃� */
	deliverstatus NUMBER(1) DEFAULT 1 NOT NULL, /* 諛곗넚�긽�깭 */
	deliverdate DATE /* 諛곗넚�셿猷뚯씪�옄 */
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

/* 二쇰Ц */
CREATE TABLE tbl_order (
	ordernum VARCHAR2(20) NOT NULL, /* 二쇰Ц肄붾뱶 */
	fk_userid VARCHAR2(20) NOT NULL, /* �쉶�썝�븘�씠�뵒(二쇰Ц�븯�떆�뒗遺�) */
	ordertotalprice NUMBER NOT NULL, /* 二쇰Ц珥앹븸 */
	ordertotalpoint NUMBER(8) NOT NULL, /* 二쇰Ц珥앺룷�씤�듃 */
	orderdate DATE DEFAULT sysdate NOT NULL, /* 二쇰Ц�씪�옄 */
	paymethod NUMBER(1), /* 寃곗젣�닔�떒 */
	name_receiver VARCHAR2(30), /* 諛쏆쑝�떆�뒗遺� */
	zipcode VARCHAR2(100), /* �슦�렪踰덊샇 */
	address VARCHAR2(200) /* 諛곗넚吏�二쇱냼 */
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

------------�떆����뒪 �깮�꽦 �떆�옉-------

/* FAQ �떆����뒪 �깮�꽦 */
     create sequence seq_faqno   
     start with 1    
     increment by 1  
     nomaxvalue     
     nocycle         
     nocache;

/* 怨듭���궗�빆 �떆����뒪 �깮�꽦 */
create sequence seq_noticeno   
     start with 1    
     increment by 1  
     nomaxvalue     
     nocycle         
     nocache;

/* �씠踰ㅽ듃 �떆����뒪 �깮�꽦 */
create sequence seq_eventno    
     start with 1    
     increment by 1  
     nomaxvalue     
     nocycle         
     nocache;

/* QNA  �떆����뒪 �깮�꽦 */
create sequence seq_qnano 
     start with 1    
     increment by 1  
     nomaxvalue     
     nocycle         
     nocache;

/* �젣�뭹援щℓ�썑湲곕━酉� �떆����뒪 �깮�꽦 */
create sequence seq_review_no  
     start with 1    
     increment by 1  
     nomaxvalue     
     nocycle         
     nocache;

/* �옣諛붽뎄�땲 �떆����뒪 �깮�꽦 */
create sequence seq_cartno  
     start with 1    
     increment by 1  
     nomaxvalue     
     nocycle         
     nocache;



------------�떆����뒪 �깮�꽦 �걹-------

  
  
  
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

<<<<<<< HEAD
commit;
>>>>>>> branch 'member_branch' of https://github.com/Helenhyerim/AnnaSemiProject.git
=======
=======
>>>>>>> branch 'main' of https://github.com/Helenhyerim/AnnaSemiProject.git
show user;
-- USER?占쏙옙(占�?) "SEMIORAUSER2"?占쏙옙?占쏙옙?占쏙옙.

grant connect, resource, create view, unlimited tablespace to SEMIORAUSER2;

select * from anna_test;

select * 
from tab;



------------------------

/* ?占쏙옙?占쏙옙 */
CREATE TABLE tbl_product (
	productnum NUMBER(8) NOT NULL, /* ?占쏙옙?占쏙옙踰덊샇 */
	categorynum NUMBER(8) NOT NULL, /* 移댄뀒怨좊━??遺꾨쪟踰덊샇 */
	productname VARCHAR2(100) NOT NULL, /* ?占쏙옙?占쏙옙占�? */
	productcompany VARCHAR2(50), /* ?占쏙옙議고쉶?占쏙옙占�? */
	productimage1 VARCHAR2(100), /* ???占쏙옙?占쏙옙?占쏙옙?占쏙옙誘몌옙?1 */
	productimage2 VARCHAR2(100), /* ???占쏙옙?占쏙옙?占쏙옙?占쏙옙誘몌옙?2 */
	productqty NUMBER(8) DEFAULT 0, /* ?占쏙옙?占쏙옙?占쏙옙怨좊웾 */
	productprice NUMBER(8) DEFAULT 0, /* ?占쏙옙?占쏙옙?占쏙옙占�? */
	saleprice NUMBER(8) DEFAULT 0, /* ?占쏙옙?占쏙옙?占쏙옙留ㅿ옙? */
	fk_specnum NUMBER(8), /* ?占쏙옙?占쏙옙踰덊샇 */
	productcontent VARCHAR2(4000), /* ?占쏙옙?占쏙옙?占쏙옙占�? */
	point NUMBER(8) DEFAULT 0, /* ?占쏙옙由쎄툑 */
	productinputdate DATE DEFAULT sysdate /* ?占쏙옙?占쏙옙?占쏙옙怨좎씪?占쏙옙 */
=======
create table anna_test
(seq          number
,name         varchar2(20) not null 
>>>>>>> branch 'main' of https://github.com/Helenhyerim/AnnaSemiProject.git
);
rollback
show user

select * from anna_test

INSERT into anna_test (seq, name)  values (1, 'choi');

<<<<<<< HEAD
/* ?占쏙옙?占쏙옙異뷂옙??占쏙옙誘몌옙? */
CREATE TABLE tbl_product_imagefile (
	imagefilenum NUMBER NOT NULL, /* ?占쏙옙誘몌옙?踰덊샇 */
	fk_productnum NUMBER(8) NOT NULL, /* ?占쏙옙?占쏙옙踰덊샇 */
	imagefilename VARCHAR2(100) NOT NULL /* ?占쏙옙誘몌옙??占쏙옙?占쏙옙占�? */
);
=======
select table tbl_notice
>>>>>>> branch 'main' of https://github.com/Helenhyerim/AnnaSemiProject.git

drop table anna_test

select * from tbl_notice

<<<<<<< HEAD
/* 移댄뀒怨좊━ */
CREATE TABLE tbl_category (
	categorynum NUMBER(8) NOT NULL, /* 移댄뀒怨좊━??遺꾨쪟踰덊샇 */
	code VARCHAR2(20) NOT NULL, /* 移댄뀒怨좊━肄붾뱶 */
	categoryname VARCHAR2(100) NOT NULL /* 移댄뀒怨좊━占�? */
);
=======
SELECT * FROM COLS WHERE TABLE_NAME = 'tbl_notice'
>>>>>>> branch 'main' of https://github.com/Helenhyerim/AnnaSemiProject.git

insert into tbl_notice (noticeno, fk_userid, noticedate, noticetitle, noticecontents) 
values (seq_noticeno.nextval, 'admin', sysdate, '1�썡 移대뱶�궗 臾댁씠�옄 �븷遺� �삙�깮�븞�궡', '�궡�슜');

insert into tbl_notice (noticeno, fk_userid, noticedate, noticetitle, noticecontents) 
values (seq_noticeno.nextval, 'admin', sysdate, 'CJ ����븳�넻�슫 �깮諛� �뙆�뾽�뿉 �뵲瑜� 諛곗넚�븞�궡', '�궡�슜');

insert into tbl_notice (noticeno, fk_userid, noticedate, noticetitle, noticecontents) 
values (seq_noticeno.nextval, 'admin', sysdate, '2021 異붿꽍�뿰�쑕 諛곗넚�븞�궡', '�궡�슜');

insert into tbl_notice (noticeno, fk_userid, noticedate, noticetitle, noticecontents) 
values (seq_noticeno.nextval, 'admin', sysdate, '2021 �뿬由� �쑕媛� 諛곗넚�븞�궡', '�궡�슜');

<<<<<<< HEAD
/* ?占쏙옙?占쏙옙?占쏙옙?占쏙옙 */
CREATE TABLE tbl_spec (
	specnum NUMBER(8) NOT NULL, /* ?占쏙옙?占쏙옙踰덊샇 */
	specname VARCHAR2(100) NOT NULL /* ?占쏙옙?占쏙옙占�? */
);
=======
>>>>>>> branch 'main' of https://github.com/Helenhyerim/AnnaSemiProject.git

select * from user_sequences

insert into tbl_member(userid, pwd, name, email, sms_status, email_status)
values ('admin', 'qwer1234$', 'admin', 'admin@gmail.com', 1, 1)

commit

select * from tbl_member
select * from tbl_notice

<<<<<<< HEAD
/* ?占쏙옙諛붽뎄?占쏙옙 */
CREATE TABLE tbl_cart (
	cartno NUMBER NOT NULL, /* ?占쏙옙諛붽뎄?占쏙옙踰덊샇 */
	fk_userid VARCHAR2(20) NOT NULL, /* ?占쏙옙?占쏙옙?占쏙옙?占쏙옙?占쏙옙 */
	fk_productnum NUMBER(8) NOT NULL, /* ?占쏙옙?占쏙옙踰덊샇 */
	orderqty NUMBER(4) DEFAULT 0, /* 二쇰Ц?占쏙옙 */
	registerday DATE DEFAULT sysdate /* ?占쏙옙?占쏙옙?占쏙옙?占쏙옙 */
);
=======
create or replace procedure pcd_notice_insert
(p_noticetitle   IN  varchar2
,p_noticecontents     IN  varchar2
)
is
begin
    for i in 1..100 loop
        insert into tbl_notice(noticeno, fk_userid, noticedate, noticetitle, noticecontents)
        values(seq_noticeno.nextval, 'admin', sysdate, p_noticetitle||i, p_noticecontents);
    end loop;
end pcd_notice_insert;
>>>>>>> branch 'main' of https://github.com/Helenhyerim/AnnaSemiProject.git

exec pcd_notice_insert('2021 �뿬由� �쑕媛� 諛곗넚�븞�궡','�뿬由� �쑕媛� 諛곗넚�븞�궡 �뿬由� �쑕媛� 諛곗넚�븞�궡�뿬由� �쑕媛� 諛곗넚�븞�궡�뿬由� �쑕媛� 諛곗넚�븞�궡�뿬由� �쑕媛� 諛곗넚�븞�궡�뿬由� �쑕媛� 諛곗넚�븞�궡');
-- PL/SQL �봽濡쒖떆���媛� �꽦怨듭쟻�쑝濡� �셿猷뚮릺�뿀�뒿�땲�떎.
exec pcd_notice_insert('CJ ����븳�넻�슫 �깮諛� �뙆�뾽�뿉 �뵲瑜� 諛곗넚�븞�궡','CJ ����븳�넻�슫 �깮諛� �뙆�뾽�뿉 �뵲瑜� 諛곗넚�븞�궡CJ ����븳�넻�슫 �깮諛� �뙆�뾽�뿉 �뵲瑜� 諛곗넚�븞�궡CJ ����븳�넻�슫 �깮諛� �뙆�뾽�뿉 �뵲瑜� 諛곗넚�븞�궡CJ ����븳�넻�슫 �깮諛� �뙆�뾽�뿉 �뵲瑜� 諛곗넚�븞�궡CJ ����븳�넻�슫 �깮諛� �뙆�뾽�뿉 �뵲瑜� 諛곗넚�븞�궡CJ ����븳�넻�슫 �깮諛� �뙆�뾽�뿉 �뵲瑜� 諛곗넚�븞�궡CJ ����븳�넻�슫 �깮諛� �뙆�뾽�뿉 �뵲瑜� 諛곗넚�븞�궡CJ ����븳�넻�슫 �깮諛� �뙆�뾽�뿉 �뵲瑜� 諛곗넚�븞�궡');

<<<<<<< HEAD
ALTER TABLE tbl_cart
	ADD
		CONSTRAINT PK_tbl_cart
		PRIMARY KEY (
			cartno
		);

/* 李쒗븯占�? */
CREATE TABLE tbl_dibs (
	fk_productnum NUMBER(8) NOT NULL, /* ?占쏙옙?占쏙옙踰덊샇 */
	fk_userid VARCHAR2(20) NOT NULL /* ?占쏙옙?占쏙옙?占쏙옙?占쏙옙?占쏙옙 */
);

/* 怨듸옙??占쏙옙?占쏙옙 */
CREATE TABLE tbl_notice (
	noticeno NUMBER NOT NULL, /* 怨듸옙??占쏙옙?占쏙옙踰덊샇 */
	fk_userid VARCHAR2(20) NOT NULL, /* ?占쏙옙?占쏙옙?占쏙옙?占쏙옙?占쏙옙 */
	noticedate DATE DEFAULT sysdate NOT NULL, /* ?占쏙옙?占쏙옙?占쏙옙?占쏙옙 */
	noticetitle VARCHAR2(100) NOT NULL, /* 占�??占쏙옙占�? */
	noticecontents VARCHAR2(4000) NOT NULL /* 占�??占쏙옙?占쏙옙 */
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

/* ?占쏙옙踰ㅽ듃 */
CREATE TABLE tbl_event (
	eventno NUMBER NOT NULL, /* ?占쏙옙踰ㅽ듃踰덊샇 */
	userid VARCHAR2(20) NOT NULL, /* ?占쏙옙?占쏙옙?占쏙옙?占쏙옙?占쏙옙 */
	eventdate DATE DEFAULT sysdate NOT NULL, /* ?占쏙옙?占쏙옙?占쏙옙?占쏙옙 */
	eventtitle VARCHAR2(100) NOT NULL, /* 占�??占쏙옙占�? */
	eventcontents VARCHAR2(4000) NOT NULL, /* 占�??占쏙옙?占쏙옙 */
	imagefilename VARCHAR2(100), /* ?占쏙옙誘몌옙? */
	eventstartdate DATE NOT NULL, /* ?占쏙옙踰ㅽ듃?占쏙옙?占쏙옙?占쏙옙 */
	eventenddate DATE /* ?占쏙옙踰ㅽ듃醫낅즺?占쏙옙 */
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

/* ?占쏙옙?占쏙옙援щℓ?占쏙옙湲곕━占�? */
CREATE TABLE tbl_purchase_reviews (
	review_no NUMBER NOT NULL, /* ?占쏙옙?占쏙옙踰덊샇 */
	fk_userid VARCHAR2(20) NOT NULL, /* ?占쏙옙?占쏙옙?占쏙옙?占쏙옙?占쏙옙 */
	fk_productnum NUMBER(8) NOT NULL, /* ?占쏙옙?占쏙옙踰덊샇 */
	reviewcontents VARCHAR2(4000) NOT NULL, /* 由щ럭?占쏙옙?占쏙옙 */
	reviewdate DATE DEFAULT sysdate /* ?占쏙옙?占쏙옙?占쏙옙?占쏙옙 */
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
	faqno NUMBER NOT NULL, /* FAQ踰덊샇 */
	fk_userid VARCHAR2(20) NOT NULL, /* ?占쏙옙?占쏙옙?占쏙옙?占쏙옙?占쏙옙 */
	faqrequesttype VARCHAR2(20) NOT NULL, /* 臾몄쓽遺꾨쪟 */
	faqtitle VARCHAR2(100) NOT NULL, /* 占�??占쏙옙占�? */
	faqcontents VARCHAR2(4000) NOT NULL /* 占�??占쏙옙?占쏙옙 */
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
	qnano NUMBER NOT NULL, /* QnA踰덊샇 */
	fk_userid VARCHAR2(20) NOT NULL, /* ?占쏙옙?占쏙옙?占쏙옙?占쏙옙?占쏙옙 */
	questiontitle VARCHAR2(100) NOT NULL, /* 吏덈Ц?占쏙옙占�? */
	questioncontents VARCHAR2(4000) NOT NULL, /* 吏덈Ц?占쏙옙?占쏙옙 */
	questiondate DATE DEFAULT sysdate NOT NULL, /* 吏덈Ц?占쏙옙?占쏙옙?占쏙옙?占쏙옙 */
	answertitle VARCHAR2(100), /* ?占쏙옙占�??占쏙옙占�? */
	answercontents VARCHAR2(4000), /* ?占쏙옙占�??占쏙옙?占쏙옙 */
	answerdate DATE DEFAULT sysdate /* ?占쏙옙占�??占쏙옙?占쏙옙?占쏙옙?占쏙옙 */
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

/* 濡쒓렇?占쏙옙湲곕줉 */
CREATE TABLE tbl_loginhistory (
	fk_userid VARCHAR2(20), /* ?占쏙옙?占쏙옙?占쏙옙?占쏙옙?占쏙옙 */
	logindate DATE DEFAULT sysdate NOT NULL, /* 濡쒓렇?占쏙옙?占쏙옙吏쒖떆占�? */
	clientip VARCHAR2(20) /* ?占쏙옙?占쏙옙IP二쇱냼 */
);

/* ?占쏙옙?占쏙옙 */
CREATE TABLE tbl_member (
	userid VARCHAR2(20) NOT NULL, /* ?占쏙옙?占쏙옙?占쏙옙?占쏙옙?占쏙옙 */
	pwd VARCHAR2(200) NOT NULL, /* ?占쏙옙?占쏙옙鍮꾬옙?踰덊샇 */
	name VARCHAR2(30) NOT NULL, /* ?占쏙옙?占쏙옙占�? */
	email VARCHAR2(200) NOT NULL, /* ?占쏙옙硫붿씪 */
	mobile VARCHAR2(200), /* ?占쏙옙???占쏙옙踰덊샇 */
	postcode VARCHAR2(10), /* ?占쏙옙?占쏙옙踰덊샇 */
	address VARCHAR2(200), /* 二쇱냼 */
	detailaddress VARCHAR2(200), /* ?占쏙옙?占쏙옙二쇱냼 */
	gender VARCHAR2(1), /* ?占쏙옙占�? */
	birthday VARCHAR2(10), /* ?占쏙옙?占쏙옙?占쏙옙?占쏙옙 */
	point NUMBER DEFAULT 0, /* ?占쏙옙由쎄툑 */
	registerday DATE DEFAULT sysdate, /* 占�??占쏙옙?占쏙옙?占쏙옙 */
	lastpwdchangedate DATE DEFAULT sysdate, /* 留덌옙?留됱븫?占쏙옙占�?寃쎈궇吏쒖떆占�? */
	register_status NUMBER(1) DEFAULT 1 NOT NULL, /* ?占쏙옙?占쏙옙?占쏙옙?占쏙옙?占쏙옙占�? */
	inactive_status NUMBER(1) DEFAULT 0 NOT NULL, /* ?占쏙옙硫댁뿬占�? */
	sms_status NUMBER(1) NOT NULL, /* SMS?占쏙옙?占쏙옙?占쏙옙?占쏙옙?占쏙옙占�? */
	email_status NUMBER(1) NOT NULL /* ?占쏙옙硫붿씪?占쏙옙?占쏙옙?占쏙옙?占쏙옙?占쏙옙占�? */
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

/* ?占쏙옙湲곗쥕?占쏙옙?占쏙옙 */
CREATE TABLE tbl_review_like (
	fk_review_no NUMBER NOT NULL, /* ?占쏙옙湲곕쾲?占쏙옙 */
	fk_userid VARCHAR2(20) NOT NULL /* ?占쏙옙?占쏙옙?占쏙옙?占쏙옙?占쏙옙 */
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

/* 二쇰Ц?占쏙옙?占쏙옙 */
CREATE TABLE tbl_orderdetail (
	orderseqnum NUMBER NOT NULL, /* 二쇰Ц?占쏙옙?占쏙옙?占쏙옙?占쏙옙踰덊샇 */
	fk_productnum NUMBER(8) NOT NULL, /* ?占쏙옙?占쏙옙踰덊샇 */
	ordernum VARCHAR2(20) NOT NULL, /* 二쇰Ц肄붾뱶 */
	orderqty NUMBER NOT NULL, /* 二쇰Ц?占쏙옙 */
	orderprice NUMBER NOT NULL, /* 二쇰Ц占�?占�? */
	deliverstatus NUMBER(1) DEFAULT 1 NOT NULL, /* 諛곗넚?占쏙옙?占쏙옙 */
	deliverdate DATE /* 諛곗넚?占쏙옙猷뚯씪?占쏙옙 */
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

/* 二쇰Ц */
CREATE TABLE tbl_order (
	ordernum VARCHAR2(20) NOT NULL, /* 二쇰Ц肄붾뱶 */
	fk_userid VARCHAR2(20) NOT NULL, /* ?占쏙옙?占쏙옙?占쏙옙?占쏙옙?占쏙옙(二쇰Ц?占쏙옙?占쏙옙?占쏙옙占�?) */
	ordertotalprice NUMBER NOT NULL, /* 二쇰Ц珥앹븸 */
	ordertotalpoint NUMBER(8) NOT NULL, /* 二쇰Ц珥앺룷?占쏙옙?占쏙옙 */
	orderdate DATE DEFAULT sysdate NOT NULL, /* 二쇰Ц?占쏙옙?占쏙옙 */
	paymethod NUMBER(1), /* 寃곗젣?占쏙옙?占쏙옙 */
	name_receiver VARCHAR2(30), /* 諛쏆쑝?占쏙옙?占쏙옙占�? */
	zipcode VARCHAR2(100), /* ?占쏙옙?占쏙옙踰덊샇 */
	address VARCHAR2(200) /* 諛곗넚占�?二쇱냼 */
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
        
        
------------?占쏙옙???占쏙옙 ?占쏙옙?占쏙옙 ?占쏙옙?占쏙옙-------

/* FAQ ?占쏙옙???占쏙옙 ?占쏙옙?占쏙옙 */
     create sequence seq_faqno   
     start with 1    
     increment by 1  
     nomaxvalue     
     nocycle         
     nocache;

/* 怨듸옙??占쏙옙?占쏙옙 ?占쏙옙???占쏙옙 ?占쏙옙?占쏙옙 */
create sequence seq_noticeno   
     start with 1    
     increment by 1  
     nomaxvalue     
     nocycle         
     nocache;

/* ?占쏙옙踰ㅽ듃 ?占쏙옙???占쏙옙 ?占쏙옙?占쏙옙 */
create sequence seq_eventno    
     start with 1    
     increment by 1  
     nomaxvalue     
     nocycle         
     nocache;

/* QNA  ?占쏙옙???占쏙옙 ?占쏙옙?占쏙옙 */
create sequence seq_qnano 
     start with 1    
     increment by 1  
     nomaxvalue     
     nocycle         
     nocache;

/* ?占쏙옙?占쏙옙援щℓ?占쏙옙湲곕━占�? ?占쏙옙???占쏙옙 ?占쏙옙?占쏙옙 */
create sequence seq_review_no  
     start with 1    
     increment by 1  
     nomaxvalue     
     nocycle         
     nocache;

/* ?占쏙옙諛붽뎄?占쏙옙 ?占쏙옙???占쏙옙 ?占쏙옙?占쏙옙 */
create sequence seq_cartno  
     start with 1    
     increment by 1  
     nomaxvalue     
     nocycle         
     nocache;

------------?占쏙옙???占쏙옙 ?占쏙옙?占쏙옙 ?占쏙옙-------

select *
  from user_sequences;
<<<<<<< HEAD
=======
=======
commit
>>>>>>> branch 'main' of https://github.com/Helenhyerim/AnnaSemiProject.git
>>>>>>> branch 'main' of https://github.com/Helenhyerim/AnnaSemiProject.git
>>>>>>> branch 'main' of https://github.com/Helenhyerim/AnnaSemiProject.git
=======
commit;
>>>>>>> branch 'member_branch' of https://github.com/Helenhyerim/AnnaSemiProject.git
=======
=======
>>>>>>> branch 'main' of https://github.com/Helenhyerim/AnnaSemiProject.git
show user;
-- USER?占쏙옙(占�?) "SEMIORAUSER2"?占쏙옙?占쏙옙?占쏙옙.

grant connect, resource, create view, unlimited tablespace to SEMIORAUSER2;

select * from anna_test;

select * 
from tab;



------------------------

/* ?占쏙옙?占쏙옙 */
CREATE TABLE tbl_product (
	productnum NUMBER(8) NOT NULL, /* ?占쏙옙?占쏙옙踰덊샇 */
	categorynum NUMBER(8) NOT NULL, /* 移댄뀒怨좊━??遺꾨쪟踰덊샇 */
	productname VARCHAR2(100) NOT NULL, /* ?占쏙옙?占쏙옙占�? */
	productcompany VARCHAR2(50), /* ?占쏙옙議고쉶?占쏙옙占�? */
	productimage1 VARCHAR2(100), /* ???占쏙옙?占쏙옙?占쏙옙?占쏙옙誘몌옙?1 */
	productimage2 VARCHAR2(100), /* ???占쏙옙?占쏙옙?占쏙옙?占쏙옙誘몌옙?2 */
	productqty NUMBER(8) DEFAULT 0, /* ?占쏙옙?占쏙옙?占쏙옙怨좊웾 */
	productprice NUMBER(8) DEFAULT 0, /* ?占쏙옙?占쏙옙?占쏙옙占�? */
	saleprice NUMBER(8) DEFAULT 0, /* ?占쏙옙?占쏙옙?占쏙옙留ㅿ옙? */
	fk_specnum NUMBER(8), /* ?占쏙옙?占쏙옙踰덊샇 */
	productcontent VARCHAR2(4000), /* ?占쏙옙?占쏙옙?占쏙옙占�? */
	point NUMBER(8) DEFAULT 0, /* ?占쏙옙由쎄툑 */
	productinputdate DATE DEFAULT sysdate /* ?占쏙옙?占쏙옙?占쏙옙怨좎씪?占쏙옙 */
=======
create table anna_test
(seq          number
,name         varchar2(20) not null 
>>>>>>> branch 'main' of https://github.com/Helenhyerim/AnnaSemiProject.git
);
rollback
show user

select * from anna_test

INSERT into anna_test (seq, name)  values (1, 'choi');

<<<<<<< HEAD
/* ?占쏙옙?占쏙옙異뷂옙??占쏙옙誘몌옙? */
CREATE TABLE tbl_product_imagefile (
	imagefilenum NUMBER NOT NULL, /* ?占쏙옙誘몌옙?踰덊샇 */
	fk_productnum NUMBER(8) NOT NULL, /* ?占쏙옙?占쏙옙踰덊샇 */
	imagefilename VARCHAR2(100) NOT NULL /* ?占쏙옙誘몌옙??占쏙옙?占쏙옙占�? */
);
=======
select table tbl_notice
>>>>>>> branch 'main' of https://github.com/Helenhyerim/AnnaSemiProject.git

drop table anna_test

select * from tbl_notice

<<<<<<< HEAD
/* 移댄뀒怨좊━ */
CREATE TABLE tbl_category (
	categorynum NUMBER(8) NOT NULL, /* 移댄뀒怨좊━??遺꾨쪟踰덊샇 */
	code VARCHAR2(20) NOT NULL, /* 移댄뀒怨좊━肄붾뱶 */
	categoryname VARCHAR2(100) NOT NULL /* 移댄뀒怨좊━占�? */
);
=======
SELECT * FROM COLS WHERE TABLE_NAME = 'tbl_notice'
>>>>>>> branch 'main' of https://github.com/Helenhyerim/AnnaSemiProject.git

insert into tbl_notice (noticeno, fk_userid, noticedate, noticetitle, noticecontents) 
values (seq_noticeno.nextval, 'admin', sysdate, '1�썡 移대뱶�궗 臾댁씠�옄 �븷遺� �삙�깮�븞�궡', '�궡�슜');

insert into tbl_notice (noticeno, fk_userid, noticedate, noticetitle, noticecontents) 
values (seq_noticeno.nextval, 'admin', sysdate, 'CJ ����븳�넻�슫 �깮諛� �뙆�뾽�뿉 �뵲瑜� 諛곗넚�븞�궡', '�궡�슜');

insert into tbl_notice (noticeno, fk_userid, noticedate, noticetitle, noticecontents) 
values (seq_noticeno.nextval, 'admin', sysdate, '2021 異붿꽍�뿰�쑕 諛곗넚�븞�궡', '�궡�슜');

insert into tbl_notice (noticeno, fk_userid, noticedate, noticetitle, noticecontents) 
values (seq_noticeno.nextval, 'admin', sysdate, '2021 �뿬由� �쑕媛� 諛곗넚�븞�궡', '�궡�슜');

<<<<<<< HEAD
/* ?占쏙옙?占쏙옙?占쏙옙?占쏙옙 */
CREATE TABLE tbl_spec (
	specnum NUMBER(8) NOT NULL, /* ?占쏙옙?占쏙옙踰덊샇 */
	specname VARCHAR2(100) NOT NULL /* ?占쏙옙?占쏙옙占�? */
);
=======
>>>>>>> branch 'main' of https://github.com/Helenhyerim/AnnaSemiProject.git

select * from user_sequences

insert into tbl_member(userid, pwd, name, email, sms_status, email_status)
values ('admin', 'qwer1234$', 'admin', 'admin@gmail.com', 1, 1)

commit

select * from tbl_member
select * from tbl_notice

<<<<<<< HEAD
/* ?占쏙옙諛붽뎄?占쏙옙 */
CREATE TABLE tbl_cart (
	cartno NUMBER NOT NULL, /* ?占쏙옙諛붽뎄?占쏙옙踰덊샇 */
	fk_userid VARCHAR2(20) NOT NULL, /* ?占쏙옙?占쏙옙?占쏙옙?占쏙옙?占쏙옙 */
	fk_productnum NUMBER(8) NOT NULL, /* ?占쏙옙?占쏙옙踰덊샇 */
	orderqty NUMBER(4) DEFAULT 0, /* 二쇰Ц?占쏙옙 */
	registerday DATE DEFAULT sysdate /* ?占쏙옙?占쏙옙?占쏙옙?占쏙옙 */
);
=======
create or replace procedure pcd_notice_insert
(p_noticetitle   IN  varchar2
,p_noticecontents     IN  varchar2
)
is
begin
    for i in 1..100 loop
        insert into tbl_notice(noticeno, fk_userid, noticedate, noticetitle, noticecontents)
        values(seq_noticeno.nextval, 'admin', sysdate, p_noticetitle||i, p_noticecontents);
    end loop;
end pcd_notice_insert;
>>>>>>> branch 'main' of https://github.com/Helenhyerim/AnnaSemiProject.git

exec pcd_notice_insert('2021 �뿬由� �쑕媛� 諛곗넚�븞�궡','�뿬由� �쑕媛� 諛곗넚�븞�궡 �뿬由� �쑕媛� 諛곗넚�븞�궡�뿬由� �쑕媛� 諛곗넚�븞�궡�뿬由� �쑕媛� 諛곗넚�븞�궡�뿬由� �쑕媛� 諛곗넚�븞�궡�뿬由� �쑕媛� 諛곗넚�븞�궡');
-- PL/SQL �봽濡쒖떆���媛� �꽦怨듭쟻�쑝濡� �셿猷뚮릺�뿀�뒿�땲�떎.
exec pcd_notice_insert('CJ ����븳�넻�슫 �깮諛� �뙆�뾽�뿉 �뵲瑜� 諛곗넚�븞�궡','CJ ����븳�넻�슫 �깮諛� �뙆�뾽�뿉 �뵲瑜� 諛곗넚�븞�궡CJ ����븳�넻�슫 �깮諛� �뙆�뾽�뿉 �뵲瑜� 諛곗넚�븞�궡CJ ����븳�넻�슫 �깮諛� �뙆�뾽�뿉 �뵲瑜� 諛곗넚�븞�궡CJ ����븳�넻�슫 �깮諛� �뙆�뾽�뿉 �뵲瑜� 諛곗넚�븞�궡CJ ����븳�넻�슫 �깮諛� �뙆�뾽�뿉 �뵲瑜� 諛곗넚�븞�궡CJ ����븳�넻�슫 �깮諛� �뙆�뾽�뿉 �뵲瑜� 諛곗넚�븞�궡CJ ����븳�넻�슫 �깮諛� �뙆�뾽�뿉 �뵲瑜� 諛곗넚�븞�궡CJ ����븳�넻�슫 �깮諛� �뙆�뾽�뿉 �뵲瑜� 諛곗넚�븞�궡');

<<<<<<< HEAD
ALTER TABLE tbl_cart
	ADD
		CONSTRAINT PK_tbl_cart
		PRIMARY KEY (
			cartno
		);

/* 李쒗븯占�? */
CREATE TABLE tbl_dibs (
	fk_productnum NUMBER(8) NOT NULL, /* ?占쏙옙?占쏙옙踰덊샇 */
	fk_userid VARCHAR2(20) NOT NULL /* ?占쏙옙?占쏙옙?占쏙옙?占쏙옙?占쏙옙 */
);

/* 怨듸옙??占쏙옙?占쏙옙 */
CREATE TABLE tbl_notice (
	noticeno NUMBER NOT NULL, /* 怨듸옙??占쏙옙?占쏙옙踰덊샇 */
	fk_userid VARCHAR2(20) NOT NULL, /* ?占쏙옙?占쏙옙?占쏙옙?占쏙옙?占쏙옙 */
	noticedate DATE DEFAULT sysdate NOT NULL, /* ?占쏙옙?占쏙옙?占쏙옙?占쏙옙 */
	noticetitle VARCHAR2(100) NOT NULL, /* 占�??占쏙옙占�? */
	noticecontents VARCHAR2(4000) NOT NULL /* 占�??占쏙옙?占쏙옙 */
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

/* ?占쏙옙踰ㅽ듃 */
CREATE TABLE tbl_event (
	eventno NUMBER NOT NULL, /* ?占쏙옙踰ㅽ듃踰덊샇 */
	userid VARCHAR2(20) NOT NULL, /* ?占쏙옙?占쏙옙?占쏙옙?占쏙옙?占쏙옙 */
	eventdate DATE DEFAULT sysdate NOT NULL, /* ?占쏙옙?占쏙옙?占쏙옙?占쏙옙 */
	eventtitle VARCHAR2(100) NOT NULL, /* 占�??占쏙옙占�? */
	eventcontents VARCHAR2(4000) NOT NULL, /* 占�??占쏙옙?占쏙옙 */
	imagefilename VARCHAR2(100), /* ?占쏙옙誘몌옙? */
	eventstartdate DATE NOT NULL, /* ?占쏙옙踰ㅽ듃?占쏙옙?占쏙옙?占쏙옙 */
	eventenddate DATE /* ?占쏙옙踰ㅽ듃醫낅즺?占쏙옙 */
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

/* ?占쏙옙?占쏙옙援щℓ?占쏙옙湲곕━占�? */
CREATE TABLE tbl_purchase_reviews (
	review_no NUMBER NOT NULL, /* ?占쏙옙?占쏙옙踰덊샇 */
	fk_userid VARCHAR2(20) NOT NULL, /* ?占쏙옙?占쏙옙?占쏙옙?占쏙옙?占쏙옙 */
	fk_productnum NUMBER(8) NOT NULL, /* ?占쏙옙?占쏙옙踰덊샇 */
	reviewcontents VARCHAR2(4000) NOT NULL, /* 由щ럭?占쏙옙?占쏙옙 */
	reviewdate DATE DEFAULT sysdate /* ?占쏙옙?占쏙옙?占쏙옙?占쏙옙 */
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
	faqno NUMBER NOT NULL, /* FAQ踰덊샇 */
	fk_userid VARCHAR2(20) NOT NULL, /* ?占쏙옙?占쏙옙?占쏙옙?占쏙옙?占쏙옙 */
	faqrequesttype VARCHAR2(20) NOT NULL, /* 臾몄쓽遺꾨쪟 */
	faqtitle VARCHAR2(100) NOT NULL, /* 占�??占쏙옙占�? */
	faqcontents VARCHAR2(4000) NOT NULL /* 占�??占쏙옙?占쏙옙 */
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
	qnano NUMBER NOT NULL, /* QnA踰덊샇 */
	fk_userid VARCHAR2(20) NOT NULL, /* ?占쏙옙?占쏙옙?占쏙옙?占쏙옙?占쏙옙 */
	questiontitle VARCHAR2(100) NOT NULL, /* 吏덈Ц?占쏙옙占�? */
	questioncontents VARCHAR2(4000) NOT NULL, /* 吏덈Ц?占쏙옙?占쏙옙 */
	questiondate DATE DEFAULT sysdate NOT NULL, /* 吏덈Ц?占쏙옙?占쏙옙?占쏙옙?占쏙옙 */
	answertitle VARCHAR2(100), /* ?占쏙옙占�??占쏙옙占�? */
	answercontents VARCHAR2(4000), /* ?占쏙옙占�??占쏙옙?占쏙옙 */
	answerdate DATE DEFAULT sysdate /* ?占쏙옙占�??占쏙옙?占쏙옙?占쏙옙?占쏙옙 */
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

/* 濡쒓렇?占쏙옙湲곕줉 */
CREATE TABLE tbl_loginhistory (
	fk_userid VARCHAR2(20), /* ?占쏙옙?占쏙옙?占쏙옙?占쏙옙?占쏙옙 */
	logindate DATE DEFAULT sysdate NOT NULL, /* 濡쒓렇?占쏙옙?占쏙옙吏쒖떆占�? */
	clientip VARCHAR2(20) /* ?占쏙옙?占쏙옙IP二쇱냼 */
);

/* ?占쏙옙?占쏙옙 */
CREATE TABLE tbl_member (
	userid VARCHAR2(20) NOT NULL, /* ?占쏙옙?占쏙옙?占쏙옙?占쏙옙?占쏙옙 */
	pwd VARCHAR2(200) NOT NULL, /* ?占쏙옙?占쏙옙鍮꾬옙?踰덊샇 */
	name VARCHAR2(30) NOT NULL, /* ?占쏙옙?占쏙옙占�? */
	email VARCHAR2(200) NOT NULL, /* ?占쏙옙硫붿씪 */
	mobile VARCHAR2(200), /* ?占쏙옙???占쏙옙踰덊샇 */
	postcode VARCHAR2(10), /* ?占쏙옙?占쏙옙踰덊샇 */
	address VARCHAR2(200), /* 二쇱냼 */
	detailaddress VARCHAR2(200), /* ?占쏙옙?占쏙옙二쇱냼 */
	gender VARCHAR2(1), /* ?占쏙옙占�? */
	birthday VARCHAR2(10), /* ?占쏙옙?占쏙옙?占쏙옙?占쏙옙 */
	point NUMBER DEFAULT 0, /* ?占쏙옙由쎄툑 */
	registerday DATE DEFAULT sysdate, /* 占�??占쏙옙?占쏙옙?占쏙옙 */
	lastpwdchangedate DATE DEFAULT sysdate, /* 留덌옙?留됱븫?占쏙옙占�?寃쎈궇吏쒖떆占�? */
	register_status NUMBER(1) DEFAULT 1 NOT NULL, /* ?占쏙옙?占쏙옙?占쏙옙?占쏙옙?占쏙옙占�? */
	inactive_status NUMBER(1) DEFAULT 0 NOT NULL, /* ?占쏙옙硫댁뿬占�? */
	sms_status NUMBER(1) NOT NULL, /* SMS?占쏙옙?占쏙옙?占쏙옙?占쏙옙?占쏙옙占�? */
	email_status NUMBER(1) NOT NULL /* ?占쏙옙硫붿씪?占쏙옙?占쏙옙?占쏙옙?占쏙옙?占쏙옙占�? */
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

/* ?占쏙옙湲곗쥕?占쏙옙?占쏙옙 */
CREATE TABLE tbl_review_like (
	fk_review_no NUMBER NOT NULL, /* ?占쏙옙湲곕쾲?占쏙옙 */
	fk_userid VARCHAR2(20) NOT NULL /* ?占쏙옙?占쏙옙?占쏙옙?占쏙옙?占쏙옙 */
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

/* 二쇰Ц?占쏙옙?占쏙옙 */
CREATE TABLE tbl_orderdetail (
	orderseqnum NUMBER NOT NULL, /* 二쇰Ц?占쏙옙?占쏙옙?占쏙옙?占쏙옙踰덊샇 */
	fk_productnum NUMBER(8) NOT NULL, /* ?占쏙옙?占쏙옙踰덊샇 */
	ordernum VARCHAR2(20) NOT NULL, /* 二쇰Ц肄붾뱶 */
	orderqty NUMBER NOT NULL, /* 二쇰Ц?占쏙옙 */
	orderprice NUMBER NOT NULL, /* 二쇰Ц占�?占�? */
	deliverstatus NUMBER(1) DEFAULT 1 NOT NULL, /* 諛곗넚?占쏙옙?占쏙옙 */
	deliverdate DATE /* 諛곗넚?占쏙옙猷뚯씪?占쏙옙 */
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

/* 二쇰Ц */
CREATE TABLE tbl_order (
	ordernum VARCHAR2(20) NOT NULL, /* 二쇰Ц肄붾뱶 */
	fk_userid VARCHAR2(20) NOT NULL, /* ?占쏙옙?占쏙옙?占쏙옙?占쏙옙?占쏙옙(二쇰Ц?占쏙옙?占쏙옙?占쏙옙占�?) */
	ordertotalprice NUMBER NOT NULL, /* 二쇰Ц珥앹븸 */
	ordertotalpoint NUMBER(8) NOT NULL, /* 二쇰Ц珥앺룷?占쏙옙?占쏙옙 */
	orderdate DATE DEFAULT sysdate NOT NULL, /* 二쇰Ц?占쏙옙?占쏙옙 */
	paymethod NUMBER(1), /* 寃곗젣?占쏙옙?占쏙옙 */
	name_receiver VARCHAR2(30), /* 諛쏆쑝?占쏙옙?占쏙옙占�? */
	zipcode VARCHAR2(100), /* ?占쏙옙?占쏙옙踰덊샇 */
	address VARCHAR2(200) /* 諛곗넚占�?二쇱냼 */
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
        
        
------------?占쏙옙???占쏙옙 ?占쏙옙?占쏙옙 ?占쏙옙?占쏙옙-------

/* FAQ ?占쏙옙???占쏙옙 ?占쏙옙?占쏙옙 */
     create sequence seq_faqno   
     start with 1    
     increment by 1  
     nomaxvalue     
     nocycle         
     nocache;

/* 怨듸옙??占쏙옙?占쏙옙 ?占쏙옙???占쏙옙 ?占쏙옙?占쏙옙 */
create sequence seq_noticeno   
     start with 1    
     increment by 1  
     nomaxvalue     
     nocycle         
     nocache;

/* ?占쏙옙踰ㅽ듃 ?占쏙옙???占쏙옙 ?占쏙옙?占쏙옙 */
create sequence seq_eventno    
     start with 1    
     increment by 1  
     nomaxvalue     
     nocycle         
     nocache;

/* QNA  ?占쏙옙???占쏙옙 ?占쏙옙?占쏙옙 */
create sequence seq_qnano 
     start with 1    
     increment by 1  
     nomaxvalue     
     nocycle         
     nocache;

/* ?占쏙옙?占쏙옙援щℓ?占쏙옙湲곕━占�? ?占쏙옙???占쏙옙 ?占쏙옙?占쏙옙 */
create sequence seq_review_no  
     start with 1    
     increment by 1  
     nomaxvalue     
     nocycle         
     nocache;

/* ?占쏙옙諛붽뎄?占쏙옙 ?占쏙옙???占쏙옙 ?占쏙옙?占쏙옙 */
create sequence seq_cartno  
     start with 1    
     increment by 1  
     nomaxvalue     
     nocycle         
     nocache;

------------?占쏙옙???占쏙옙 ?占쏙옙?占쏙옙 ?占쏙옙-------

select *
  from user_sequences;
<<<<<<< HEAD
=======
=======
commit
>>>>>>> branch 'main' of https://github.com/Helenhyerim/AnnaSemiProject.git
>>>>>>> branch 'main' of https://github.com/Helenhyerim/AnnaSemiProject.git
>>>>>>> branch 'main' of https://github.com/Helenhyerim/AnnaSemiProject.git
=======
select * from anna_test;
>>>>>>> branch 'product_branch4' of https://github.com/Helenhyerim/AnnaSemiProject.git
