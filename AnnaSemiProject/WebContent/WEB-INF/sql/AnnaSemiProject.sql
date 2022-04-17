show user;
-- USER?´(ê°?) "SEMIORAUSER2"?…?‹ˆ?‹¤.

grant connect, resource, create view, unlimited tablespace to SEMIORAUSER2;

select *
from tbl_member
order by registerday desc;
commit

update tbl_member set pwd = '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382'
                    , email = 'TydU2C+Xay1SxjpsL1yhxw=='
                    , mobile = 'AX7K6pBHjDhUMnGGWWtDdQ=='
where userid='admin';

commit;

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

insert into TBL_CATEGORY(CATEGORYNUM,CODE,CATEGORYNAME) values (1, 'code-01','ëª©ê±¸?´');
insert into TBL_CATEGORY(CATEGORYNUM,CODE,CATEGORYNAME) values (2, 'code-02','ê·?ê±¸ì´');
insert into TBL_CATEGORY(CATEGORYNUM,CODE,CATEGORYNAME) values (3, 'code-03','ë°˜ì?');
insert into TBL_CATEGORY(CATEGORYNUM,CODE,CATEGORYNAME) values (4, 'code-04','?Œ”ì°?');
commit;

insert into tbl_spec(SPECNUM,SPECNAME) values(1, '?¼ë°˜ìƒ?’ˆ');
commit;
-----tbl_product ?— ?„£?„ ? œ?’ˆ?“¤ ?”„ë¡œì‹œ?? ?ƒ?„±-------------------------

insert into tbl_product(PRODUCTNUM,CATEGORYNUM,PRODUCTNAME,PRODUCTIMAGE1,PRODUCTIMAGE2,PRODUCTQTY,PRODUCTPRICE,SALEPRICE,FK_SPECNUM,PRODUCTINPUTDATE)
values(1, 3, 'ë°˜ì?1', 'p1.png', 'p2.png', 20, 345000, 334650, 1, sysdate);

insert into tbl_product(PRODUCTNUM,CATEGORYNUM,PRODUCTNAME,PRODUCTIMAGE1,PRODUCTIMAGE2,PRODUCTQTY,PRODUCTPRICE,SALEPRICE,FK_SPECNUM,PRODUCTINPUTDATE)
values(2, 3, 'ë°˜ì?2', 'p1.png', 'p2.png', 20, 345000, 334650, 1, sysdate);

insert into tbl_product(PRODUCTNUM,CATEGORYNUM,PRODUCTNAME,PRODUCTIMAGE1,PRODUCTIMAGE2,PRODUCTQTY,PRODUCTPRICE,SALEPRICE,FK_SPECNUM,PRODUCTINPUTDATE)
values(3, 3, 'ë°˜ì?3', 'p1.png', 'p2.png', 20, 345000, 334650, 1, sysdate);

insert into tbl_product(PRODUCTNUM,CATEGORYNUM,PRODUCTNAME,PRODUCTIMAGE1,PRODUCTIMAGE2,PRODUCTQTY,PRODUCTPRICE,SALEPRICE,FK_SPECNUM,PRODUCTINPUTDATE)
values(4, 3, 'ë°˜ì?4', 'p1.png', 'p2.png', 20, 345000, 334650, 1, sysdate);

insert into tbl_product(PRODUCTNUM,CATEGORYNUM,PRODUCTNAME,PRODUCTIMAGE1,PRODUCTIMAGE2,PRODUCTQTY,PRODUCTPRICE,SALEPRICE,FK_SPECNUM,PRODUCTINPUTDATE)
values(5, 3, 'ë°˜ì?5', 'p1.png', 'p2.png', 20, 345000, 334650, 1, sysdate);
commit;
------------------------

/* ? œ?’ˆ */
CREATE TABLE tbl_product (
	productnum NUMBER(8) NOT NULL, /* ? œ?’ˆë²ˆí˜¸ */
	categorynum NUMBER(8) NOT NULL, /* ì¹´í…Œê³ ë¦¬??ë¶„ë¥˜ë²ˆí˜¸ */
	productname VARCHAR2(100) NOT NULL, /* ? œ?’ˆëª? */
	productcompany VARCHAR2(50), /* ? œì¡°íšŒ?‚¬ëª? */
	productimage1 VARCHAR2(100), /* ???‘œ? œ?’ˆ?´ë¯¸ì?1 */
	productimage2 VARCHAR2(100), /* ???‘œ? œ?’ˆ?´ë¯¸ì?2 */
	productqty NUMBER(8) DEFAULT 0, /* ? œ?’ˆ?¬ê³ ëŸ‰ */
	productprice NUMBER(8) DEFAULT 0, /* ? œ?’ˆ? •ê°? */
	saleprice NUMBER(8) DEFAULT 0, /* ? œ?’ˆ?Œë§¤ê? */
	fk_specnum NUMBER(8), /* ?Š¤?™ë²ˆí˜¸ */
	productcontent VARCHAR2(4000), /* ? œ?’ˆ?„¤ëª? */
	point NUMBER(8) DEFAULT 0, /* ? ë¦½ê¸ˆ */
	productinputdate DATE DEFAULT sysdate /* ? œ?’ˆ?…ê³ ì¼? */
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

/* ? œ?’ˆì¶”ê??´ë¯¸ì? */
CREATE TABLE tbl_product_imagefile (
	imagefilenum NUMBER NOT NULL, /* ?´ë¯¸ì?ë²ˆí˜¸ */
	fk_productnum NUMBER(8) NOT NULL, /* ? œ?’ˆë²ˆí˜¸ */
	imagefilename VARCHAR2(100) NOT NULL /* ?´ë¯¸ì??ŒŒ?¼ëª? */
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

/* ì¹´í…Œê³ ë¦¬ */
CREATE TABLE tbl_category (
	categorynum NUMBER(8) NOT NULL, /* ì¹´í…Œê³ ë¦¬??ë¶„ë¥˜ë²ˆí˜¸ */
	code VARCHAR2(20) NOT NULL, /* ì¹´í…Œê³ ë¦¬ì½”ë“œ */
	categoryname VARCHAR2(100) NOT NULL /* ì¹´í…Œê³ ë¦¬ëª? */
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

/* ? œ?’ˆ?Š¤?™ */
CREATE TABLE tbl_spec (
	specnum NUMBER(8) NOT NULL, /* ?Š¤?™ë²ˆí˜¸ */
	specname VARCHAR2(100) NOT NULL /* ?Š¤?™ëª? */
);
select *
from tbl_spec

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

/* ?¥ë°”êµ¬?‹ˆ */
CREATE TABLE tbl_cart (
	cartno NUMBER NOT NULL, /* ?¥ë°”êµ¬?‹ˆë²ˆí˜¸ */
	fk_userid VARCHAR2(20) NOT NULL, /* ?šŒ?›?•„?´?”” */
	fk_productnum NUMBER(8) NOT NULL, /* ? œ?’ˆë²ˆí˜¸ */
	orderqty NUMBER(4) DEFAULT 0, /* ì£¼ë¬¸?Ÿ‰ */
	registerday DATE DEFAULT sysdate /* ?…? ¥?¼? */
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

/* ì°œí•˜ê¸? */
CREATE TABLE tbl_dibs (
	fk_productnum NUMBER(8) NOT NULL, /* ? œ?’ˆë²ˆí˜¸ */
	fk_userid VARCHAR2(20) NOT NULL /* ?šŒ?›?•„?´?”” */
);

/* ê³µì??‚¬?•­ */
CREATE TABLE tbl_notice (
	noticeno NUMBER NOT NULL, /* ê³µì??‚¬?•­ë²ˆí˜¸ */
	fk_userid VARCHAR2(20) NOT NULL, /* ?šŒ?›?•„?´?”” */
	noticedate DATE DEFAULT sysdate NOT NULL, /* ?‘?„±?¼? */
	noticetitle VARCHAR2(100) NOT NULL, /* ê¸?? œëª? */
	noticecontents VARCHAR2(4000) NOT NULL /* ê¸??‚´?š© */
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

/* ?´ë²¤íŠ¸ */
CREATE TABLE tbl_event (
	eventno NUMBER NOT NULL, /* ?´ë²¤íŠ¸ë²ˆí˜¸ */
	userid VARCHAR2(20) NOT NULL, /* ?šŒ?›?•„?´?”” */
	eventdate DATE DEFAULT sysdate NOT NULL, /* ?‘?„±?¼? */
	eventtitle VARCHAR2(100) NOT NULL, /* ê¸?? œëª? */
	eventcontents VARCHAR2(4000) NOT NULL, /* ê¸??‚´?š© */
	imagefilename VARCHAR2(100), /* ?´ë¯¸ì? */
	eventstartdate DATE NOT NULL, /* ?´ë²¤íŠ¸?‹œ?‘?¼ */
	eventenddate DATE /* ?´ë²¤íŠ¸ì¢…ë£Œ?¼ */
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

/* ? œ?’ˆêµ¬ë§¤?›„ê¸°ë¦¬ë·? */
CREATE TABLE tbl_purchase_reviews (
	review_no NUMBER NOT NULL, /* ?‘?„±ë²ˆí˜¸ */
	fk_userid VARCHAR2(20) NOT NULL, /* ?šŒ?›?•„?´?”” */
	fk_productnum NUMBER(8) NOT NULL, /* ? œ?’ˆë²ˆí˜¸ */
	reviewcontents VARCHAR2(4000) NOT NULL, /* ë¦¬ë·°?‚´?š© */
	reviewdate DATE DEFAULT sysdate /* ?‘?„±?¼? */
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
	faqno NUMBER NOT NULL, /* FAQë²ˆí˜¸ */
	fk_userid VARCHAR2(20) NOT NULL, /* ?šŒ?›?•„?´?”” */
	faqrequesttype VARCHAR2(20) NOT NULL, /* ë¬¸ì˜ë¶„ë¥˜ */
	faqtitle VARCHAR2(100) NOT NULL, /* ê¸?? œëª? */
	faqcontents VARCHAR2(4000) NOT NULL /* ê¸??‚´?š© */
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
	qnano NUMBER NOT NULL, /* QnAë²ˆí˜¸ */
	fk_userid VARCHAR2(20) NOT NULL, /* ?šŒ?›?•„?´?”” */
	questiontitle VARCHAR2(100) NOT NULL, /* ì§ˆë¬¸? œëª? */
	questioncontents VARCHAR2(4000) NOT NULL, /* ì§ˆë¬¸?‚´?š© */
	questiondate DATE DEFAULT sysdate NOT NULL, /* ì§ˆë¬¸?‘?„±?¼? */
	answertitle VARCHAR2(100), /* ?‹µë³?? œëª? */
	answercontents VARCHAR2(4000), /* ?‹µë³??‚´?š© */
	answerdate DATE DEFAULT sysdate /* ?‹µë³??‘?„±?¼? */
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

/* ë¡œê·¸?¸ê¸°ë¡ */
CREATE TABLE tbl_loginhistory (
	fk_userid VARCHAR2(20), /* ?šŒ?›?•„?´?”” */
	logindate DATE DEFAULT sysdate NOT NULL, /* ë¡œê·¸?¸?‚ ì§œì‹œê°? */
	clientip VARCHAR2(20) /* ? ‘?†IPì£¼ì†Œ */
);

/* ?šŒ?› */
CREATE TABLE tbl_member (
	userid VARCHAR2(20) NOT NULL, /* ?šŒ?›?•„?´?”” */
	pwd VARCHAR2(200) NOT NULL, /* ?šŒ?›ë¹„ë?ë²ˆí˜¸ */
	name VARCHAR2(30) NOT NULL, /* ?šŒ?›ëª? */
	email VARCHAR2(200) NOT NULL, /* ?´ë©”ì¼ */
	mobile VARCHAR2(200), /* ?œ´???°ë²ˆí˜¸ */
	postcode VARCHAR2(10), /* ?š°?¸ë²ˆí˜¸ */
	address VARCHAR2(200), /* ì£¼ì†Œ */
	detailaddress VARCHAR2(200), /* ?ƒ?„¸ì£¼ì†Œ */
	gender VARCHAR2(1), /* ?„±ë³? */
	birthday VARCHAR2(10), /* ?ƒ?…„?›”?¼ */
	point NUMBER DEFAULT 0, /* ? ë¦½ê¸ˆ */
	registerday DATE DEFAULT sysdate, /* ê°??…?¼? */
	lastpwdchangedate DATE DEFAULT sysdate, /* ë§ˆì?ë§‰ì•”?˜¸ë³?ê²½ë‚ ì§œì‹œê°? */
	register_status NUMBER(1) DEFAULT 1 NOT NULL, /* ?šŒ?›?ƒˆ?‡´?—¬ë¶? */
	inactive_status NUMBER(1) DEFAULT 0 NOT NULL, /* ?œ´ë©´ì—¬ë¶? */
	sms_status NUMBER(1) NOT NULL, /* SMS?ˆ˜?‹ ?™?˜?—¬ë¶? */
	email_status NUMBER(1) NOT NULL /* ?´ë©”ì¼?ˆ˜?‹ ?™?˜?—¬ë¶? */
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

/* ?›„ê¸°ì¢‹?•„?š” */
CREATE TABLE tbl_review_like (
	fk_review_no NUMBER NOT NULL, /* ?›„ê¸°ë²ˆ?˜¸ */
	fk_userid VARCHAR2(20) NOT NULL /* ?šŒ?›?•„?´?”” */
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

/* ì£¼ë¬¸?ƒ?„¸ */
CREATE TABLE tbl_orderdetail (
	orderseqnum NUMBER NOT NULL, /* ì£¼ë¬¸?ƒ?„¸?¼? ¨ë²ˆí˜¸ */
	fk_productnum NUMBER(8) NOT NULL, /* ? œ?’ˆë²ˆí˜¸ */
	ordernum VARCHAR2(20) NOT NULL, /* ì£¼ë¬¸ì½”ë“œ */
	orderqty NUMBER NOT NULL, /* ì£¼ë¬¸?Ÿ‰ */
	orderprice NUMBER NOT NULL, /* ì£¼ë¬¸ê°?ê²? */
	deliverstatus NUMBER(1) DEFAULT 1 NOT NULL, /* ë°°ì†¡?ƒ?ƒœ */
	deliverdate DATE /* ë°°ì†¡?™„ë£Œì¼? */
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

/* ì£¼ë¬¸ */
CREATE TABLE tbl_order (
	ordernum VARCHAR2(20) NOT NULL, /* ì£¼ë¬¸ì½”ë“œ */
	fk_userid VARCHAR2(20) NOT NULL, /* ?šŒ?›?•„?´?””(ì£¼ë¬¸?•˜?‹œ?Š”ë¶?) */
	ordertotalprice NUMBER NOT NULL, /* ì£¼ë¬¸ì´ì•¡ */
	ordertotalpoint NUMBER(8) NOT NULL, /* ì£¼ë¬¸ì´í¬?¸?Š¸ */
	orderdate DATE DEFAULT sysdate NOT NULL, /* ì£¼ë¬¸?¼? */
	paymethod NUMBER(1), /* ê²°ì œ?ˆ˜?‹¨ */
	name_receiver VARCHAR2(30), /* ë°›ìœ¼?‹œ?Š”ë¶? */
	zipcode VARCHAR2(100), /* ?š°?¸ë²ˆí˜¸ */
	address VARCHAR2(200) /* ë°°ì†¡ì§?ì£¼ì†Œ */
);
select *
from tbl_dibs
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
        
        
------------?‹œ???Š¤ ?ƒ?„± ?‹œ?‘-------

/* FAQ ?‹œ???Š¤ ?ƒ?„± */
     create sequence seq_faqno   
     start with 1    
     increment by 1  
     nomaxvalue     
     nocycle         
     nocache;

/* ê³µì??‚¬?•­ ?‹œ???Š¤ ?ƒ?„± */
create sequence seq_noticeno   
     start with 1    
     increment by 1  
     nomaxvalue     
     nocycle         
     nocache;

/* ?´ë²¤íŠ¸ ?‹œ???Š¤ ?ƒ?„± */
create sequence seq_eventno    
     start with 1    
     increment by 1  
     nomaxvalue     
     nocycle         
     nocache;

/* QNA  ?‹œ???Š¤ ?ƒ?„± */
create sequence seq_qnano 
     start with 1    
     increment by 1  
     nomaxvalue     
     nocycle         
     nocache;

/* ? œ?’ˆêµ¬ë§¤?›„ê¸°ë¦¬ë·? ?‹œ???Š¤ ?ƒ?„± */
create sequence seq_review_no  
     start with 1    
     increment by 1  
     nomaxvalue     
     nocycle         
     nocache;

/* ?¥ë°”êµ¬?‹ˆ ?‹œ???Š¤ ?ƒ?„± */
create sequence seq_cartno  
     start with 1    
     increment by 1  
     nomaxvalue     
     nocycle         
     nocache;

------------?‹œ???Š¤ ?ƒ?„± ?-------

select *
  from user_sequences;


/* ? œ?’ˆ */
CREATE TABLE tbl_product (
	productnum NUMBER(8) NOT NULL, /* ? œ?’ˆë²ˆí˜¸ */
	categorynum NUMBER(8) NOT NULL, /* ì¹´í…Œê³ ë¦¬??ë¶„ë¥˜ë²ˆí˜¸ */
	productname VARCHAR2(100) NOT NULL, /* ? œ?’ˆëª? */
	productcompany VARCHAR2(50), /* ? œì¡°íšŒ?‚¬ëª? */
	productimage1 VARCHAR2(100), /* ???‘œ? œ?’ˆ?´ë¯¸ì?1 */
	productimage2 VARCHAR2(100), /* ???‘œ? œ?’ˆ?´ë¯¸ì?2 */
	productqty NUMBER(8) DEFAULT 0, /* ? œ?’ˆ?¬ê³ ëŸ‰ */
	productprice NUMBER(8) DEFAULT 0, /* ? œ?’ˆ? •ê°? */
	saleprice NUMBER(8) DEFAULT 0, /* ? œ?’ˆ?Œë§¤ê? */
	fk_specnum NUMBER(8), /* ?Š¤?™ë²ˆí˜¸ */
	productcontent VARCHAR2(4000), /* ? œ?’ˆ?„¤ëª? */
	point NUMBER(8) DEFAULT 0, /* ? ë¦½ê¸ˆ */
	productinputdate DATE DEFAULT sysdate /* ? œ?’ˆ?…ê³ ì¼? */
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

/* ? œ?’ˆì¶”ê??´ë¯¸ì? */
CREATE TABLE tbl_product_imagefile (
	imagefilenum NUMBER NOT NULL, /* ?´ë¯¸ì?ë²ˆí˜¸ */
	fk_productnum NUMBER(8) NOT NULL, /* ? œ?’ˆë²ˆí˜¸ */
	imagefilename VARCHAR2(100) NOT NULL /* ?´ë¯¸ì??ŒŒ?¼ëª? */
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

/* ì¹´í…Œê³ ë¦¬ */
CREATE TABLE tbl_category (
	categorynum NUMBER(8) NOT NULL, /* ì¹´í…Œê³ ë¦¬??ë¶„ë¥˜ë²ˆí˜¸ */
	code VARCHAR2(20) NOT NULL, /* ì¹´í…Œê³ ë¦¬ì½”ë“œ */
	categoryname VARCHAR2(100) NOT NULL /* ì¹´í…Œê³ ë¦¬ëª? */
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

/* ? œ?’ˆ?Š¤?™ */
CREATE TABLE tbl_spec (
	specnum NUMBER(8) NOT NULL, /* ?Š¤?™ë²ˆí˜¸ */
	specname VARCHAR2(100) NOT NULL /* ?Š¤?™ëª? */
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

/* ?¥ë°”êµ¬?‹ˆ */
CREATE TABLE tbl_cart (
	cartno NUMBER NOT NULL, /* ?¥ë°”êµ¬?‹ˆë²ˆí˜¸ */
	fk_userid VARCHAR2(20) NOT NULL, /* ?šŒ?›?•„?´?”” */
	fk_productnum NUMBER(8) NOT NULL, /* ? œ?’ˆë²ˆí˜¸ */
	orderqty NUMBER(4) DEFAULT 0, /* ì£¼ë¬¸?Ÿ‰ */
	registerday DATE DEFAULT sysdate /* ?…? ¥?¼? */
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

/* ì°œí•˜ê¸? */
CREATE TABLE tbl_dibs (
	fk_productnum NUMBER(8) NOT NULL, /* ? œ?’ˆë²ˆí˜¸ */
	fk_userid VARCHAR2(20) NOT NULL /* ?šŒ?›?•„?´?”” */
);

/* ê³µì??‚¬?•­ */
CREATE TABLE tbl_notice (
	noticeno NUMBER NOT NULL, /* ê³µì??‚¬?•­ë²ˆí˜¸ */
	fk_userid VARCHAR2(20) NOT NULL, /* ?šŒ?›?•„?´?”” */
	noticedate DATE DEFAULT sysdate NOT NULL, /* ?‘?„±?¼? */
	noticetitle VARCHAR2(100) NOT NULL, /* ê¸?? œëª? */
	noticecontents VARCHAR2(4000) NOT NULL /* ê¸??‚´?š© */
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

/* ?´ë²¤íŠ¸ */
CREATE TABLE tbl_event (
	eventno NUMBER NOT NULL, /* ?´ë²¤íŠ¸ë²ˆí˜¸ */
	userid VARCHAR2(20) NOT NULL, /* ?šŒ?›?•„?´?”” */
	eventdate DATE DEFAULT sysdate NOT NULL, /* ?‘?„±?¼? */
	eventtitle VARCHAR2(100) NOT NULL, /* ê¸?? œëª? */
	eventcontents VARCHAR2(4000) NOT NULL, /* ê¸??‚´?š© */
	imagefilename VARCHAR2(100), /* ?´ë¯¸ì? */
	eventstartdate DATE NOT NULL, /* ?´ë²¤íŠ¸?‹œ?‘?¼ */
	eventenddate DATE /* ?´ë²¤íŠ¸ì¢…ë£Œ?¼ */
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

/* ? œ?’ˆêµ¬ë§¤?›„ê¸°ë¦¬ë·? */
CREATE TABLE tbl_purchase_reviews (
	review_no NUMBER NOT NULL, /* ?‘?„±ë²ˆí˜¸ */
	fk_userid VARCHAR2(20) NOT NULL, /* ?šŒ?›?•„?´?”” */
	fk_productnum NUMBER(8) NOT NULL, /* ? œ?’ˆë²ˆí˜¸ */
	reviewcontents VARCHAR2(4000) NOT NULL, /* ë¦¬ë·°?‚´?š© */
	reviewdate DATE DEFAULT sysdate /* ?‘?„±?¼? */
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
	faqno NUMBER NOT NULL, /* FAQë²ˆí˜¸ */
	fk_userid VARCHAR2(20) NOT NULL, /* ?šŒ?›?•„?´?”” */
	faqrequesttype VARCHAR2(20) NOT NULL, /* ë¬¸ì˜ë¶„ë¥˜ */
	faqtitle VARCHAR2(100) NOT NULL, /* ê¸?? œëª? */
	faqcontents VARCHAR2(4000) NOT NULL /* ê¸??‚´?š© */
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
	qnano NUMBER NOT NULL, /* QnAë²ˆí˜¸ */
	fk_userid VARCHAR2(20) NOT NULL, /* ?šŒ?›?•„?´?”” */
	questiontitle VARCHAR2(100) NOT NULL, /* ì§ˆë¬¸? œëª? */
	questioncontents VARCHAR2(4000) NOT NULL, /* ì§ˆë¬¸?‚´?š© */
	questiondate DATE DEFAULT sysdate NOT NULL, /* ì§ˆë¬¸?‘?„±?¼? */
	answertitle VARCHAR2(100), /* ?‹µë³?? œëª? */
	answercontents VARCHAR2(4000), /* ?‹µë³??‚´?š© */
	answerdate DATE DEFAULT sysdate /* ?‹µë³??‘?„±?¼? */
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

/* ë¡œê·¸?¸ê¸°ë¡ */
CREATE TABLE tbl_loginhistory (
	fk_userid VARCHAR2(20), /* ?šŒ?›?•„?´?”” */
	logindate DATE DEFAULT sysdate NOT NULL, /* ë¡œê·¸?¸?‚ ì§œì‹œê°? */
	clientip VARCHAR2(20) /* ? ‘?†IPì£¼ì†Œ */
);

/* ?šŒ?› */
CREATE TABLE tbl_member (
	userid VARCHAR2(20) NOT NULL, /* ?šŒ?›?•„?´?”” */
	pwd VARCHAR2(200) NOT NULL, /* ?šŒ?›ë¹„ë?ë²ˆí˜¸ */
	name VARCHAR2(30) NOT NULL, /* ?šŒ?›ëª? */
	email VARCHAR2(200) NOT NULL, /* ?´ë©”ì¼ */
	mobile VARCHAR2(200), /* ?œ´???°ë²ˆí˜¸ */
	postcode VARCHAR2(10), /* ?š°?¸ë²ˆí˜¸ */
	address VARCHAR2(200), /* ì£¼ì†Œ */
	detailaddress VARCHAR2(200), /* ?ƒ?„¸ì£¼ì†Œ */
	gender VARCHAR2(1), /* ?„±ë³? */
	birthday VARCHAR2(10), /* ?ƒ?…„?›”?¼ */
	point NUMBER DEFAULT 0, /* ? ë¦½ê¸ˆ */
	registerday DATE DEFAULT sysdate, /* ê°??…?¼? */
	lastpwdchangedate DATE DEFAULT sysdate, /* ë§ˆì?ë§‰ì•”?˜¸ë³?ê²½ë‚ ì§œì‹œê°? */
	register_status NUMBER(1) DEFAULT 1 NOT NULL, /* ?šŒ?›?ƒˆ?‡´?—¬ë¶? */
	inactive_status NUMBER(1) DEFAULT 0 NOT NULL, /* ?œ´ë©´ì—¬ë¶? */
	sms_status NUMBER(1) NOT NULL, /* SMS?ˆ˜?‹ ?™?˜?—¬ë¶? */
	email_status NUMBER(1) NOT NULL /* ?´ë©”ì¼?ˆ˜?‹ ?™?˜?—¬ë¶? */
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

/* ?›„ê¸°ì¢‹?•„?š” */
CREATE TABLE tbl_review_like (
	fk_review_no NUMBER NOT NULL, /* ?›„ê¸°ë²ˆ?˜¸ */
	fk_userid VARCHAR2(20) NOT NULL /* ?šŒ?›?•„?´?”” */
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

/* ì£¼ë¬¸?ƒ?„¸ */
CREATE TABLE tbl_orderdetail (
	orderseqnum NUMBER NOT NULL, /* ì£¼ë¬¸?ƒ?„¸?¼? ¨ë²ˆí˜¸ */
	fk_productnum NUMBER(8) NOT NULL, /* ? œ?’ˆë²ˆí˜¸ */
	ordernum VARCHAR2(20) NOT NULL, /* ì£¼ë¬¸ì½”ë“œ */
	orderqty NUMBER NOT NULL, /* ì£¼ë¬¸?Ÿ‰ */
	orderprice NUMBER NOT NULL, /* ì£¼ë¬¸ê°?ê²? */
	deliverstatus NUMBER(1) DEFAULT 1 NOT NULL, /* ë°°ì†¡?ƒ?ƒœ */
	deliverdate DATE /* ë°°ì†¡?™„ë£Œì¼? */
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

/* ì£¼ë¬¸ */
CREATE TABLE tbl_order (
	ordernum VARCHAR2(20) NOT NULL, /* ì£¼ë¬¸ì½”ë“œ */
	fk_userid VARCHAR2(20) NOT NULL, /* ?šŒ?›?•„?´?””(ì£¼ë¬¸?•˜?‹œ?Š”ë¶?) */
	ordertotalprice NUMBER NOT NULL, /* ì£¼ë¬¸ì´ì•¡ */
	ordertotalpoint NUMBER(8) NOT NULL, /* ì£¼ë¬¸ì´í¬?¸?Š¸ */
	orderdate DATE DEFAULT sysdate NOT NULL, /* ì£¼ë¬¸?¼? */
	paymethod NUMBER(1), /* ê²°ì œ?ˆ˜?‹¨ */
	name_receiver VARCHAR2(30), /* ë°›ìœ¼?‹œ?Š”ë¶? */
	zipcode VARCHAR2(100), /* ?š°?¸ë²ˆí˜¸ */
	address VARCHAR2(200) /* ë°°ì†¡ì§?ì£¼ì†Œ */
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

------------?‹œ???Š¤ ?ƒ?„± ?‹œ?‘-------

/* FAQ ?‹œ???Š¤ ?ƒ?„± */
     create sequence seq_faqno   
     start with 1    
     increment by 1  
     nomaxvalue     
     nocycle         
     nocache;

/* ê³µì??‚¬?•­ ?‹œ???Š¤ ?ƒ?„± */
create sequence seq_noticeno   
     start with 1    
     increment by 1  
     nomaxvalue     
     nocycle         
     nocache;

/* ?´ë²¤íŠ¸ ?‹œ???Š¤ ?ƒ?„± */
create sequence seq_eventno    
     start with 1    
     increment by 1  
     nomaxvalue     
     nocycle         
     nocache;

/* QNA  ?‹œ???Š¤ ?ƒ?„± */
create sequence seq_qnano 
     start with 1    
     increment by 1  
     nomaxvalue     
     nocycle         
     nocache;

/* ? œ?’ˆêµ¬ë§¤?›„ê¸°ë¦¬ë·? ?‹œ???Š¤ ?ƒ?„± */
create sequence seq_review_no  
     start with 1    
     increment by 1  
     nomaxvalue     
     nocycle         
     nocache;

/* ?¥ë°”êµ¬?‹ˆ ?‹œ???Š¤ ?ƒ?„± */
create sequence seq_cartno  
     start with 1    
     increment by 1  
     nomaxvalue     
     nocycle         
     nocache;



------------?‹œ???Š¤ ?ƒ?„± ?-------
  
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

show user;
-- USER?ï¿½ï¿½(ï¿??) "SEMIORAUSER2"?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½.

grant connect, resource, create view, unlimited tablespace to SEMIORAUSER2;

select * from anna_test;

select * 
from tab;



------------------------

/* ?ï¿½ï¿½?ï¿½ï¿½ */
CREATE TABLE tbl_product (
	productnum NUMBER(8) NOT NULL, /* ?ï¿½ï¿½?ï¿½ï¿½ë²ˆí˜¸ */
	categorynum NUMBER(8) NOT NULL, /* ì¹´í…Œê³ ë¦¬??ë¶„ë¥˜ë²ˆí˜¸ */
	productname VARCHAR2(100) NOT NULL, /* ?ï¿½ï¿½?ï¿½ï¿½ï¿?? */
	productcompany VARCHAR2(50), /* ?ï¿½ï¿½ì¡°íšŒ?ï¿½ï¿½ï¿?? */
	productimage1 VARCHAR2(100), /* ???ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½ë¯¸ï¿½?1 */
	productimage2 VARCHAR2(100), /* ???ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½ë¯¸ï¿½?2 */
	productqty NUMBER(8) DEFAULT 0, /* ?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½ê³ ëŸ‰ */
	productprice NUMBER(8) DEFAULT 0, /* ?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½ï¿?? */
	saleprice NUMBER(8) DEFAULT 0, /* ?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½ë§¤ï¿½? */
	fk_specnum NUMBER(8), /* ?ï¿½ï¿½?ï¿½ï¿½ë²ˆí˜¸ */
	productcontent VARCHAR2(4000), /* ?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½ï¿?? */
	point NUMBER(8) DEFAULT 0, /* ?ï¿½ï¿½ë¦½ê¸ˆ */
	productinputdate DATE DEFAULT sysdate /* ?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½ê³ ì¼?ï¿½ï¿½ */
create table anna_test
(seq          number
,name         varchar2(20) not null 
);
rollback
show user

select * from anna_test

INSERT into anna_test (seq, name)  values (1, 'choi');

/* ?ï¿½ï¿½?ï¿½ï¿½ì¶”ï¿½??ï¿½ï¿½ë¯¸ï¿½? */
CREATE TABLE tbl_product_imagefile (
	imagefilenum NUMBER NOT NULL, /* ?ï¿½ï¿½ë¯¸ï¿½?ë²ˆí˜¸ */
	fk_productnum NUMBER(8) NOT NULL, /* ?ï¿½ï¿½?ï¿½ï¿½ë²ˆí˜¸ */
	imagefilename VARCHAR2(100) NOT NULL /* ?ï¿½ï¿½ë¯¸ï¿½??ï¿½ï¿½?ï¿½ï¿½ï¿?? */
);

select table tbl_notice

drop table anna_test

select * from tbl_notice

/* ì¹´í…Œê³ ë¦¬ */
CREATE TABLE tbl_category (
	categorynum NUMBER(8) NOT NULL, /* ì¹´í…Œê³ ë¦¬??ë¶„ë¥˜ë²ˆí˜¸ */
	code VARCHAR2(20) NOT NULL, /* ì¹´í…Œê³ ë¦¬ì½”ë“œ */
	categoryname VARCHAR2(100) NOT NULL /* ì¹´í…Œê³ ë¦¬ï¿?? */
);

SELECT * FROM COLS WHERE TABLE_NAME = 'tbl_notice'

insert into tbl_notice (noticeno, fk_userid, noticedate, noticetitle, noticecontents) 
values (seq_noticeno.nextval, 'admin', sysdate, '1?›” ì¹´ë“œ?‚¬ ë¬´ì´? ?• ë¶? ?˜œ?ƒ?•ˆ?‚´', '?‚´?š©');

insert into tbl_notice (noticeno, fk_userid, noticedate, noticetitle, noticecontents) 
values (seq_noticeno.nextval, 'admin', sysdate, 'CJ ???•œ?†µ?š´ ?ƒë°? ?ŒŒ?—…?— ?”°ë¥? ë°°ì†¡?•ˆ?‚´', '?‚´?š©');

insert into tbl_notice (noticeno, fk_userid, noticedate, noticetitle, noticecontents) 
values (seq_noticeno.nextval, 'admin', sysdate, '2021 ì¶”ì„?—°?œ´ ë°°ì†¡?•ˆ?‚´', '?‚´?š©');

insert into tbl_notice (noticeno, fk_userid, noticedate, noticetitle, noticecontents) 
values (seq_noticeno.nextval, 'admin', sysdate, '2021 ?—¬ë¦? ?œ´ê°? ë°°ì†¡?•ˆ?‚´', '?‚´?š©');

/* ?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½ */
CREATE TABLE tbl_spec (
	specnum NUMBER(8) NOT NULL, /* ?ï¿½ï¿½?ï¿½ï¿½ë²ˆí˜¸ */
	specname VARCHAR2(100) NOT NULL /* ?ï¿½ï¿½?ï¿½ï¿½ï¿?? */
);


select * from user_sequences

insert into tbl_member(userid, pwd, name, email, sms_status, email_status)
values ('admin', 'qwer1234$', 'admin', 'admin@gmail.com', 1, 1)

commit

select * from tbl_member
select * from tbl_notice

/* ?ï¿½ï¿½ë°”êµ¬?ï¿½ï¿½ */
CREATE TABLE tbl_cart (
	cartno NUMBER NOT NULL, /* ?ï¿½ï¿½ë°”êµ¬?ï¿½ï¿½ë²ˆí˜¸ */
	fk_userid VARCHAR2(20) NOT NULL, /* ?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½ */
	fk_productnum NUMBER(8) NOT NULL, /* ?ï¿½ï¿½?ï¿½ï¿½ë²ˆí˜¸ */
	orderqty NUMBER(4) DEFAULT 0, /* ì£¼ë¬¸?ï¿½ï¿½ */
	registerday DATE DEFAULT sysdate /* ?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½ */
);

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

exec pcd_notice_insert('2021 ?—¬ë¦? ?œ´ê°? ë°°ì†¡?•ˆ?‚´','?—¬ë¦? ?œ´ê°? ë°°ì†¡?•ˆ?‚´ ?—¬ë¦? ?œ´ê°? ë°°ì†¡?•ˆ?‚´?—¬ë¦? ?œ´ê°? ë°°ì†¡?•ˆ?‚´?—¬ë¦? ?œ´ê°? ë°°ì†¡?•ˆ?‚´?—¬ë¦? ?œ´ê°? ë°°ì†¡?•ˆ?‚´?—¬ë¦? ?œ´ê°? ë°°ì†¡?•ˆ?‚´');
-- PL/SQL ?”„ë¡œì‹œ??ê°? ?„±ê³µì ?œ¼ë¡? ?™„ë£Œë˜?—ˆ?Šµ?‹ˆ?‹¤.
exec pcd_notice_insert('CJ ???•œ?†µ?š´ ?ƒë°? ?ŒŒ?—…?— ?”°ë¥? ë°°ì†¡?•ˆ?‚´','CJ ???•œ?†µ?š´ ?ƒë°? ?ŒŒ?—…?— ?”°ë¥? ë°°ì†¡?•ˆ?‚´CJ ???•œ?†µ?š´ ?ƒë°? ?ŒŒ?—…?— ?”°ë¥? ë°°ì†¡?•ˆ?‚´CJ ???•œ?†µ?š´ ?ƒë°? ?ŒŒ?—…?— ?”°ë¥? ë°°ì†¡?•ˆ?‚´CJ ???•œ?†µ?š´ ?ƒë°? ?ŒŒ?—…?— ?”°ë¥? ë°°ì†¡?•ˆ?‚´CJ ???•œ?†µ?š´ ?ƒë°? ?ŒŒ?—…?— ?”°ë¥? ë°°ì†¡?•ˆ?‚´CJ ???•œ?†µ?š´ ?ƒë°? ?ŒŒ?—…?— ?”°ë¥? ë°°ì†¡?•ˆ?‚´CJ ???•œ?†µ?š´ ?ƒë°? ?ŒŒ?—…?— ?”°ë¥? ë°°ì†¡?•ˆ?‚´CJ ???•œ?†µ?š´ ?ƒë°? ?ŒŒ?—…?— ?”°ë¥? ë°°ì†¡?•ˆ?‚´');

ALTER TABLE tbl_cart
	ADD
		CONSTRAINT PK_tbl_cart
		PRIMARY KEY (
			cartno
		);

/* ì°œí•˜ï¿?? */
CREATE TABLE tbl_dibs (
	fk_productnum NUMBER(8) NOT NULL, /* ?ï¿½ï¿½?ï¿½ï¿½ë²ˆí˜¸ */
	fk_userid VARCHAR2(20) NOT NULL /* ?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½ */
);

/* ê³µï¿½??ï¿½ï¿½?ï¿½ï¿½ */
CREATE TABLE tbl_notice (
	noticeno NUMBER NOT NULL, /* ê³µï¿½??ï¿½ï¿½?ï¿½ï¿½ë²ˆí˜¸ */
	fk_userid VARCHAR2(20) NOT NULL, /* ?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½ */
	noticedate DATE DEFAULT sysdate NOT NULL, /* ?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½ */
	noticetitle VARCHAR2(100) NOT NULL, /* ï¿???ï¿½ï¿½ï¿?? */
	noticecontents VARCHAR2(4000) NOT NULL /* ï¿???ï¿½ï¿½?ï¿½ï¿½ */
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

/* ?ï¿½ï¿½ë²¤íŠ¸ */
CREATE TABLE tbl_event (
	eventno NUMBER NOT NULL, /* ?ï¿½ï¿½ë²¤íŠ¸ë²ˆí˜¸ */
	userid VARCHAR2(20) NOT NULL, /* ?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½ */
	eventdate DATE DEFAULT sysdate NOT NULL, /* ?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½ */
	eventtitle VARCHAR2(100) NOT NULL, /* ï¿???ï¿½ï¿½ï¿?? */
	eventcontents VARCHAR2(4000) NOT NULL, /* ï¿???ï¿½ï¿½?ï¿½ï¿½ */
	imagefilename VARCHAR2(100), /* ?ï¿½ï¿½ë¯¸ï¿½? */
	eventstartdate DATE NOT NULL, /* ?ï¿½ï¿½ë²¤íŠ¸?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½ */
	eventenddate DATE /* ?ï¿½ï¿½ë²¤íŠ¸ì¢…ë£Œ?ï¿½ï¿½ */
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

/* ?ï¿½ï¿½?ï¿½ï¿½êµ¬ë§¤?ï¿½ï¿½ê¸°ë¦¬ï¿?? */
CREATE TABLE tbl_purchase_reviews (
	review_no NUMBER NOT NULL, /* ?ï¿½ï¿½?ï¿½ï¿½ë²ˆí˜¸ */
	fk_userid VARCHAR2(20) NOT NULL, /* ?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½ */
	fk_productnum NUMBER(8) NOT NULL, /* ?ï¿½ï¿½?ï¿½ï¿½ë²ˆí˜¸ */
	reviewcontents VARCHAR2(4000) NOT NULL, /* ë¦¬ë·°?ï¿½ï¿½?ï¿½ï¿½ */
	reviewdate DATE DEFAULT sysdate /* ?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½ */
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
	faqno NUMBER NOT NULL, /* FAQë²ˆí˜¸ */
	fk_userid VARCHAR2(20) NOT NULL, /* ?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½ */
	faqrequesttype VARCHAR2(20) NOT NULL, /* ë¬¸ì˜ë¶„ë¥˜ */
	faqtitle VARCHAR2(100) NOT NULL, /* ï¿???ï¿½ï¿½ï¿?? */
	faqcontents VARCHAR2(4000) NOT NULL /* ï¿???ï¿½ï¿½?ï¿½ï¿½ */
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
	qnano NUMBER NOT NULL, /* QnAë²ˆí˜¸ */
	fk_userid VARCHAR2(20) NOT NULL, /* ?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½ */
	questiontitle VARCHAR2(100) NOT NULL, /* ì§ˆë¬¸?ï¿½ï¿½ï¿?? */
	questioncontents VARCHAR2(4000) NOT NULL, /* ì§ˆë¬¸?ï¿½ï¿½?ï¿½ï¿½ */
	questiondate DATE DEFAULT sysdate NOT NULL, /* ì§ˆë¬¸?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½ */
	answertitle VARCHAR2(100), /* ?ï¿½ï¿½ï¿???ï¿½ï¿½ï¿?? */
	answercontents VARCHAR2(4000), /* ?ï¿½ï¿½ï¿???ï¿½ï¿½?ï¿½ï¿½ */
	answerdate DATE DEFAULT sysdate /* ?ï¿½ï¿½ï¿???ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½ */
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

/* ë¡œê·¸?ï¿½ï¿½ê¸°ë¡ */
CREATE TABLE tbl_loginhistory (
	fk_userid VARCHAR2(20), /* ?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½ */
	logindate DATE DEFAULT sysdate NOT NULL, /* ë¡œê·¸?ï¿½ï¿½?ï¿½ï¿½ì§œì‹œï¿?? */
	clientip VARCHAR2(20) /* ?ï¿½ï¿½?ï¿½ï¿½IPì£¼ì†Œ */
);

/* ?ï¿½ï¿½?ï¿½ï¿½ */
CREATE TABLE tbl_member (
	userid VARCHAR2(20) NOT NULL, /* ?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½ */
	pwd VARCHAR2(200) NOT NULL, /* ?ï¿½ï¿½?ï¿½ï¿½ë¹„ï¿½?ë²ˆí˜¸ */
	name VARCHAR2(30) NOT NULL, /* ?ï¿½ï¿½?ï¿½ï¿½ï¿?? */
	email VARCHAR2(200) NOT NULL, /* ?ï¿½ï¿½ë©”ì¼ */
	mobile VARCHAR2(200), /* ?ï¿½ï¿½???ï¿½ï¿½ë²ˆí˜¸ */
	postcode VARCHAR2(10), /* ?ï¿½ï¿½?ï¿½ï¿½ë²ˆí˜¸ */
	address VARCHAR2(200), /* ì£¼ì†Œ */
	detailaddress VARCHAR2(200), /* ?ï¿½ï¿½?ï¿½ï¿½ì£¼ì†Œ */
	gender VARCHAR2(1), /* ?ï¿½ï¿½ï¿?? */
	birthday VARCHAR2(10), /* ?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½ */
	point NUMBER DEFAULT 0, /* ?ï¿½ï¿½ë¦½ê¸ˆ */
	registerday DATE DEFAULT sysdate, /* ï¿???ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½ */
	lastpwdchangedate DATE DEFAULT sysdate, /* ë§ˆï¿½?ë§‰ì•”?ï¿½ï¿½ï¿??ê²½ë‚ ì§œì‹œï¿?? */
	register_status NUMBER(1) DEFAULT 1 NOT NULL, /* ?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½ï¿?? */
	inactive_status NUMBER(1) DEFAULT 0 NOT NULL, /* ?ï¿½ï¿½ë©´ì—¬ï¿?? */
	sms_status NUMBER(1) NOT NULL, /* SMS?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½ï¿?? */
	email_status NUMBER(1) NOT NULL /* ?ï¿½ï¿½ë©”ì¼?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½ï¿?? */
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

/* ?ï¿½ï¿½ê¸°ì¢‹?ï¿½ï¿½?ï¿½ï¿½ */
CREATE TABLE tbl_review_like (
	fk_review_no NUMBER NOT NULL, /* ?ï¿½ï¿½ê¸°ë²ˆ?ï¿½ï¿½ */
	fk_userid VARCHAR2(20) NOT NULL /* ?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½ */
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

/* ì£¼ë¬¸?ï¿½ï¿½?ï¿½ï¿½ */
CREATE TABLE tbl_orderdetail (
	orderseqnum NUMBER NOT NULL, /* ì£¼ë¬¸?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½ë²ˆí˜¸ */
	fk_productnum NUMBER(8) NOT NULL, /* ?ï¿½ï¿½?ï¿½ï¿½ë²ˆí˜¸ */
	ordernum VARCHAR2(20) NOT NULL, /* ì£¼ë¬¸ì½”ë“œ */
	orderqty NUMBER NOT NULL, /* ì£¼ë¬¸?ï¿½ï¿½ */
	orderprice NUMBER NOT NULL, /* ì£¼ë¬¸ï¿??ï¿?? */
	deliverstatus NUMBER(1) DEFAULT 1 NOT NULL, /* ë°°ì†¡?ï¿½ï¿½?ï¿½ï¿½ */
	deliverdate DATE /* ë°°ì†¡?ï¿½ï¿½ë£Œì¼?ï¿½ï¿½ */
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

/* ì£¼ë¬¸ */
CREATE TABLE tbl_order (
	ordernum VARCHAR2(20) NOT NULL, /* ì£¼ë¬¸ì½”ë“œ */
	fk_userid VARCHAR2(20) NOT NULL, /* ?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½(ì£¼ë¬¸?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½ï¿??) */
	ordertotalprice NUMBER NOT NULL, /* ì£¼ë¬¸ì´ì•¡ */
	ordertotalpoint NUMBER(8) NOT NULL, /* ì£¼ë¬¸ì´í¬?ï¿½ï¿½?ï¿½ï¿½ */
	orderdate DATE DEFAULT sysdate NOT NULL, /* ì£¼ë¬¸?ï¿½ï¿½?ï¿½ï¿½ */
	paymethod NUMBER(1), /* ê²°ì œ?ï¿½ï¿½?ï¿½ï¿½ */
	name_receiver VARCHAR2(30), /* ë°›ìœ¼?ï¿½ï¿½?ï¿½ï¿½ï¿?? */
	zipcode VARCHAR2(100), /* ?ï¿½ï¿½?ï¿½ï¿½ë²ˆí˜¸ */
	address VARCHAR2(200) /* ë°°ì†¡ï¿??ì£¼ì†Œ */
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
        
        
------------?ï¿½ï¿½???ï¿½ï¿½ ?ï¿½ï¿½?ï¿½ï¿½ ?ï¿½ï¿½?ï¿½ï¿½-------

/* FAQ ?ï¿½ï¿½???ï¿½ï¿½ ?ï¿½ï¿½?ï¿½ï¿½ */
     create sequence seq_faqno   
     start with 1    
     increment by 1  
     nomaxvalue     
     nocycle         
     nocache;

/* ê³µï¿½??ï¿½ï¿½?ï¿½ï¿½ ?ï¿½ï¿½???ï¿½ï¿½ ?ï¿½ï¿½?ï¿½ï¿½ */
create sequence seq_noticeno   
     start with 1    
     increment by 1  
     nomaxvalue     
     nocycle         
     nocache;

/* ?ï¿½ï¿½ë²¤íŠ¸ ?ï¿½ï¿½???ï¿½ï¿½ ?ï¿½ï¿½?ï¿½ï¿½ */
create sequence seq_eventno    
     start with 1    
     increment by 1  
     nomaxvalue     
     nocycle         
     nocache;

/* QNA  ?ï¿½ï¿½???ï¿½ï¿½ ?ï¿½ï¿½?ï¿½ï¿½ */
create sequence seq_qnano 
     start with 1    
     increment by 1  
     nomaxvalue     
     nocycle         
     nocache;

/* ?ï¿½ï¿½?ï¿½ï¿½êµ¬ë§¤?ï¿½ï¿½ê¸°ë¦¬ï¿?? ?ï¿½ï¿½???ï¿½ï¿½ ?ï¿½ï¿½?ï¿½ï¿½ */
create sequence seq_review_no  
     start with 1    
     increment by 1  
     nomaxvalue     
     nocycle         
     nocache;

/* ?ï¿½ï¿½ë°”êµ¬?ï¿½ï¿½ ?ï¿½ï¿½???ï¿½ï¿½ ?ï¿½ï¿½?ï¿½ï¿½ */
create sequence seq_cartno  
     start with 1    
     increment by 1  
     nomaxvalue     
     nocycle         
     nocache;

------------?ï¿½ï¿½???ï¿½ï¿½ ?ï¿½ï¿½?ï¿½ï¿½ ?ï¿½ï¿½-------

select *
  from user_sequences;

commit

commit;

show user;
-- USER?ï¿½ï¿½(ï¿??) "SEMIORAUSER2"?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½.

grant connect, resource, create view, unlimited tablespace to SEMIORAUSER2;

select * from anna_test;

select * 
from tab;



------------------------

/* ?ï¿½ï¿½?ï¿½ï¿½ */
CREATE TABLE tbl_product (
	productnum NUMBER(8) NOT NULL, /* ?ï¿½ï¿½?ï¿½ï¿½ë²ˆí˜¸ */
	categorynum NUMBER(8) NOT NULL, /* ì¹´í…Œê³ ë¦¬??ë¶„ë¥˜ë²ˆí˜¸ */
	productname VARCHAR2(100) NOT NULL, /* ?ï¿½ï¿½?ï¿½ï¿½ï¿?? */
	productcompany VARCHAR2(50), /* ?ï¿½ï¿½ì¡°íšŒ?ï¿½ï¿½ï¿?? */
	productimage1 VARCHAR2(100), /* ???ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½ë¯¸ï¿½?1 */
	productimage2 VARCHAR2(100), /* ???ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½ë¯¸ï¿½?2 */
	productqty NUMBER(8) DEFAULT 0, /* ?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½ê³ ëŸ‰ */
	productprice NUMBER(8) DEFAULT 0, /* ?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½ï¿?? */
	saleprice NUMBER(8) DEFAULT 0, /* ?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½ë§¤ï¿½? */
	fk_specnum NUMBER(8), /* ?ï¿½ï¿½?ï¿½ï¿½ë²ˆí˜¸ */
	productcontent VARCHAR2(4000), /* ?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½ï¿?? */
	point NUMBER(8) DEFAULT 0, /* ?ï¿½ï¿½ë¦½ê¸ˆ */
	productinputdate DATE DEFAULT sysdate /* ?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½ê³ ì¼?ï¿½ï¿½ */

create table anna_test
(seq          number
,name         varchar2(20) not null 
);

rollback

show user

select * from anna_test

INSERT into anna_test (seq, name)  values (1, 'choi');

/* ?ï¿½ï¿½?ï¿½ï¿½ì¶”ï¿½??ï¿½ï¿½ë¯¸ï¿½? */
CREATE TABLE tbl_product_imagefile (
	imagefilenum NUMBER NOT NULL, /* ?ï¿½ï¿½ë¯¸ï¿½?ë²ˆí˜¸ */
	fk_productnum NUMBER(8) NOT NULL, /* ?ï¿½ï¿½?ï¿½ï¿½ë²ˆí˜¸ */
	imagefilename VARCHAR2(100) NOT NULL /* ?ï¿½ï¿½ë¯¸ï¿½??ï¿½ï¿½?ï¿½ï¿½ï¿?? */
);

select table tbl_notice

drop table anna_test

select * from tbl_notice

/* ì¹´í…Œê³ ë¦¬ */
CREATE TABLE tbl_category (
	categorynum NUMBER(8) NOT NULL, /* ì¹´í…Œê³ ë¦¬??ë¶„ë¥˜ë²ˆí˜¸ */
	code VARCHAR2(20) NOT NULL, /* ì¹´í…Œê³ ë¦¬ì½”ë“œ */
	categoryname VARCHAR2(100) NOT NULL /* ì¹´í…Œê³ ë¦¬ï¿?? */
);

SELECT * FROM COLS WHERE TABLE_NAME = 'tbl_notice'

insert into tbl_notice (noticeno, fk_userid, noticedate, noticetitle, noticecontents) 
values (seq_noticeno.nextval, 'admin', sysdate, '1?›” ì¹´ë“œ?‚¬ ë¬´ì´? ?• ë¶? ?˜œ?ƒ?•ˆ?‚´', '?‚´?š©');

insert into tbl_notice (noticeno, fk_userid, noticedate, noticetitle, noticecontents) 
values (seq_noticeno.nextval, 'admin', sysdate, 'CJ ???•œ?†µ?š´ ?ƒë°? ?ŒŒ?—…?— ?”°ë¥? ë°°ì†¡?•ˆ?‚´', '?‚´?š©');

insert into tbl_notice (noticeno, fk_userid, noticedate, noticetitle, noticecontents) 
values (seq_noticeno.nextval, 'admin', sysdate, '2021 ì¶”ì„?—°?œ´ ë°°ì†¡?•ˆ?‚´', '?‚´?š©');

insert into tbl_notice (noticeno, fk_userid, noticedate, noticetitle, noticecontents) 
values (seq_noticeno.nextval, 'admin', sysdate, '2021 ?—¬ë¦? ?œ´ê°? ë°°ì†¡?•ˆ?‚´', '?‚´?š©');

/* ?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½ */
CREATE TABLE tbl_spec (
	specnum NUMBER(8) NOT NULL, /* ?ï¿½ï¿½?ï¿½ï¿½ë²ˆí˜¸ */
	specname VARCHAR2(100) NOT NULL /* ?ï¿½ï¿½?ï¿½ï¿½ï¿?? */
);

select * from user_sequences

insert into tbl_member(userid, pwd, name, email, sms_status, email_status)
values ('admin', 'qwer1234$', 'admin', 'admin@gmail.com', 1, 1)

commit

select * from tbl_member
select * from tbl_notice

/* ?ï¿½ï¿½ë°”êµ¬?ï¿½ï¿½ */
CREATE TABLE tbl_cart (
	cartno NUMBER NOT NULL, /* ?ï¿½ï¿½ë°”êµ¬?ï¿½ï¿½ë²ˆí˜¸ */
	fk_userid VARCHAR2(20) NOT NULL, /* ?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½ */
	fk_productnum NUMBER(8) NOT NULL, /* ?ï¿½ï¿½?ï¿½ï¿½ë²ˆí˜¸ */
	orderqty NUMBER(4) DEFAULT 0, /* ì£¼ë¬¸?ï¿½ï¿½ */
	registerday DATE DEFAULT sysdate /* ?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½ */
);

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

exec pcd_notice_insert('2021 ?—¬ë¦? ?œ´ê°? ë°°ì†¡?•ˆ?‚´','?—¬ë¦? ?œ´ê°? ë°°ì†¡?•ˆ?‚´ ?—¬ë¦? ?œ´ê°? ë°°ì†¡?•ˆ?‚´?—¬ë¦? ?œ´ê°? ë°°ì†¡?•ˆ?‚´?—¬ë¦? ?œ´ê°? ë°°ì†¡?•ˆ?‚´?—¬ë¦? ?œ´ê°? ë°°ì†¡?•ˆ?‚´?—¬ë¦? ?œ´ê°? ë°°ì†¡?•ˆ?‚´');
-- PL/SQL ?”„ë¡œì‹œ??ê°? ?„±ê³µì ?œ¼ë¡? ?™„ë£Œë˜?—ˆ?Šµ?‹ˆ?‹¤.
exec pcd_notice_insert('CJ ???•œ?†µ?š´ ?ƒë°? ?ŒŒ?—…?— ?”°ë¥? ë°°ì†¡?•ˆ?‚´','CJ ???•œ?†µ?š´ ?ƒë°? ?ŒŒ?—…?— ?”°ë¥? ë°°ì†¡?•ˆ?‚´CJ ???•œ?†µ?š´ ?ƒë°? ?ŒŒ?—…?— ?”°ë¥? ë°°ì†¡?•ˆ?‚´CJ ???•œ?†µ?š´ ?ƒë°? ?ŒŒ?—…?— ?”°ë¥? ë°°ì†¡?•ˆ?‚´CJ ???•œ?†µ?š´ ?ƒë°? ?ŒŒ?—…?— ?”°ë¥? ë°°ì†¡?•ˆ?‚´CJ ???•œ?†µ?š´ ?ƒë°? ?ŒŒ?—…?— ?”°ë¥? ë°°ì†¡?•ˆ?‚´CJ ???•œ?†µ?š´ ?ƒë°? ?ŒŒ?—…?— ?”°ë¥? ë°°ì†¡?•ˆ?‚´CJ ???•œ?†µ?š´ ?ƒë°? ?ŒŒ?—…?— ?”°ë¥? ë°°ì†¡?•ˆ?‚´CJ ???•œ?†µ?š´ ?ƒë°? ?ŒŒ?—…?— ?”°ë¥? ë°°ì†¡?•ˆ?‚´');

ALTER TABLE tbl_cart
	ADD
		CONSTRAINT PK_tbl_cart
		PRIMARY KEY (
			cartno
		);

/* ì°œí•˜ï¿?? */
CREATE TABLE tbl_dibs (
	fk_productnum NUMBER(8) NOT NULL, /* ?ï¿½ï¿½?ï¿½ï¿½ë²ˆí˜¸ */
	fk_userid VARCHAR2(20) NOT NULL /* ?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½ */
);

/* ê³µï¿½??ï¿½ï¿½?ï¿½ï¿½ */
CREATE TABLE tbl_notice (
	noticeno NUMBER NOT NULL, /* ê³µï¿½??ï¿½ï¿½?ï¿½ï¿½ë²ˆí˜¸ */
	fk_userid VARCHAR2(20) NOT NULL, /* ?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½ */
	noticedate DATE DEFAULT sysdate NOT NULL, /* ?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½ */
	noticetitle VARCHAR2(100) NOT NULL, /* ï¿???ï¿½ï¿½ï¿?? */
	noticecontents VARCHAR2(4000) NOT NULL /* ï¿???ï¿½ï¿½?ï¿½ï¿½ */
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

/* ?ï¿½ï¿½ë²¤íŠ¸ */
CREATE TABLE tbl_event (
	eventno NUMBER NOT NULL, /* ?ï¿½ï¿½ë²¤íŠ¸ë²ˆí˜¸ */
	userid VARCHAR2(20) NOT NULL, /* ?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½ */
	eventdate DATE DEFAULT sysdate NOT NULL, /* ?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½ */
	eventtitle VARCHAR2(100) NOT NULL, /* ï¿???ï¿½ï¿½ï¿?? */
	eventcontents VARCHAR2(4000) NOT NULL, /* ï¿???ï¿½ï¿½?ï¿½ï¿½ */
	imagefilename VARCHAR2(100), /* ?ï¿½ï¿½ë¯¸ï¿½? */
	eventstartdate DATE NOT NULL, /* ?ï¿½ï¿½ë²¤íŠ¸?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½ */
	eventenddate DATE /* ?ï¿½ï¿½ë²¤íŠ¸ì¢…ë£Œ?ï¿½ï¿½ */
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

/* ?ï¿½ï¿½?ï¿½ï¿½êµ¬ë§¤?ï¿½ï¿½ê¸°ë¦¬ï¿?? */
CREATE TABLE tbl_purchase_reviews (
	review_no NUMBER NOT NULL, /* ?ï¿½ï¿½?ï¿½ï¿½ë²ˆí˜¸ */
	fk_userid VARCHAR2(20) NOT NULL, /* ?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½ */
	fk_productnum NUMBER(8) NOT NULL, /* ?ï¿½ï¿½?ï¿½ï¿½ë²ˆí˜¸ */
	reviewcontents VARCHAR2(4000) NOT NULL, /* ë¦¬ë·°?ï¿½ï¿½?ï¿½ï¿½ */
	reviewdate DATE DEFAULT sysdate /* ?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½ */
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
	faqno NUMBER NOT NULL, /* FAQë²ˆí˜¸ */
	fk_userid VARCHAR2(20) NOT NULL, /* ?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½ */
	faqrequesttype VARCHAR2(20) NOT NULL, /* ë¬¸ì˜ë¶„ë¥˜ */
	faqtitle VARCHAR2(100) NOT NULL, /* ï¿???ï¿½ï¿½ï¿?? */
	faqcontents VARCHAR2(4000) NOT NULL /* ï¿???ï¿½ï¿½?ï¿½ï¿½ */
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
	qnano NUMBER NOT NULL, /* QnAë²ˆí˜¸ */
	fk_userid VARCHAR2(20) NOT NULL, /* ?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½ */
	questiontitle VARCHAR2(100) NOT NULL, /* ì§ˆë¬¸?ï¿½ï¿½ï¿?? */
	questioncontents VARCHAR2(4000) NOT NULL, /* ì§ˆë¬¸?ï¿½ï¿½?ï¿½ï¿½ */
	questiondate DATE DEFAULT sysdate NOT NULL, /* ì§ˆë¬¸?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½ */
	answertitle VARCHAR2(100), /* ?ï¿½ï¿½ï¿???ï¿½ï¿½ï¿?? */
	answercontents VARCHAR2(4000), /* ?ï¿½ï¿½ï¿???ï¿½ï¿½?ï¿½ï¿½ */
	answerdate DATE DEFAULT sysdate /* ?ï¿½ï¿½ï¿???ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½ */
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

/* ë¡œê·¸?ï¿½ï¿½ê¸°ë¡ */
CREATE TABLE tbl_loginhistory (
	fk_userid VARCHAR2(20), /* ?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½ */
	logindate DATE DEFAULT sysdate NOT NULL, /* ë¡œê·¸?ï¿½ï¿½?ï¿½ï¿½ì§œì‹œï¿?? */
	clientip VARCHAR2(20) /* ?ï¿½ï¿½?ï¿½ï¿½IPì£¼ì†Œ */
);

/* ?ï¿½ï¿½?ï¿½ï¿½ */
CREATE TABLE tbl_member (
	userid VARCHAR2(20) NOT NULL, /* ?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½ */
	pwd VARCHAR2(200) NOT NULL, /* ?ï¿½ï¿½?ï¿½ï¿½ë¹„ï¿½?ë²ˆí˜¸ */
	name VARCHAR2(30) NOT NULL, /* ?ï¿½ï¿½?ï¿½ï¿½ï¿?? */
	email VARCHAR2(200) NOT NULL, /* ?ï¿½ï¿½ë©”ì¼ */
	mobile VARCHAR2(200), /* ?ï¿½ï¿½???ï¿½ï¿½ë²ˆí˜¸ */
	postcode VARCHAR2(10), /* ?ï¿½ï¿½?ï¿½ï¿½ë²ˆí˜¸ */
	address VARCHAR2(200), /* ì£¼ì†Œ */
	detailaddress VARCHAR2(200), /* ?ï¿½ï¿½?ï¿½ï¿½ì£¼ì†Œ */
	gender VARCHAR2(1), /* ?ï¿½ï¿½ï¿?? */
	birthday VARCHAR2(10), /* ?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½ */
	point NUMBER DEFAULT 0, /* ?ï¿½ï¿½ë¦½ê¸ˆ */
	registerday DATE DEFAULT sysdate, /* ï¿???ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½ */
	lastpwdchangedate DATE DEFAULT sysdate, /* ë§ˆï¿½?ë§‰ì•”?ï¿½ï¿½ï¿??ê²½ë‚ ì§œì‹œï¿?? */
	register_status NUMBER(1) DEFAULT 1 NOT NULL, /* ?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½ï¿?? */
	inactive_status NUMBER(1) DEFAULT 0 NOT NULL, /* ?ï¿½ï¿½ë©´ì—¬ï¿?? */
	sms_status NUMBER(1) NOT NULL, /* SMS?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½ï¿?? */
	email_status NUMBER(1) NOT NULL /* ?ï¿½ï¿½ë©”ì¼?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½ï¿?? */
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

/* ?ï¿½ï¿½ê¸°ì¢‹?ï¿½ï¿½?ï¿½ï¿½ */
CREATE TABLE tbl_review_like (
	fk_review_no NUMBER NOT NULL, /* ?ï¿½ï¿½ê¸°ë²ˆ?ï¿½ï¿½ */
	fk_userid VARCHAR2(20) NOT NULL /* ?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½ */
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

/* ì£¼ë¬¸?ï¿½ï¿½?ï¿½ï¿½ */
CREATE TABLE tbl_orderdetail (
	orderseqnum NUMBER NOT NULL, /* ì£¼ë¬¸?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½ë²ˆí˜¸ */
	fk_productnum NUMBER(8) NOT NULL, /* ?ï¿½ï¿½?ï¿½ï¿½ë²ˆí˜¸ */
	ordernum VARCHAR2(20) NOT NULL, /* ì£¼ë¬¸ì½”ë“œ */
	orderqty NUMBER NOT NULL, /* ì£¼ë¬¸?ï¿½ï¿½ */
	orderprice NUMBER NOT NULL, /* ì£¼ë¬¸ï¿??ï¿?? */
	deliverstatus NUMBER(1) DEFAULT 1 NOT NULL, /* ë°°ì†¡?ï¿½ï¿½?ï¿½ï¿½ */
	deliverdate DATE /* ë°°ì†¡?ï¿½ï¿½ë£Œì¼?ï¿½ï¿½ */
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

/* ì£¼ë¬¸ */
CREATE TABLE tbl_order (
	ordernum VARCHAR2(20) NOT NULL, /* ì£¼ë¬¸ì½”ë“œ */
	fk_userid VARCHAR2(20) NOT NULL, /* ?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½(ì£¼ë¬¸?ï¿½ï¿½?ï¿½ï¿½?ï¿½ï¿½ï¿??) */
	ordertotalprice NUMBER NOT NULL, /* ì£¼ë¬¸ì´ì•¡ */
	ordertotalpoint NUMBER(8) NOT NULL, /* ì£¼ë¬¸ì´í¬?ï¿½ï¿½?ï¿½ï¿½ */
	orderdate DATE DEFAULT sysdate NOT NULL, /* ì£¼ë¬¸?ï¿½ï¿½?ï¿½ï¿½ */
	paymethod NUMBER(1), /* ê²°ì œ?ï¿½ï¿½?ï¿½ï¿½ */
	name_receiver VARCHAR2(30), /* ë°›ìœ¼?ï¿½ï¿½?ï¿½ï¿½ï¿?? */
	zipcode VARCHAR2(100), /* ?ï¿½ï¿½?ï¿½ï¿½ë²ˆí˜¸ */
	address VARCHAR2(200) /* ë°°ì†¡ï¿??ì£¼ì†Œ */
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
        
        
------------?ï¿½ï¿½???ï¿½ï¿½ ?ï¿½ï¿½?ï¿½ï¿½ ?ï¿½ï¿½?ï¿½ï¿½-------

/* FAQ ?ï¿½ï¿½???ï¿½ï¿½ ?ï¿½ï¿½?ï¿½ï¿½ */
     create sequence seq_faqno   
     start with 1    
     increment by 1  
     nomaxvalue     
     nocycle         
     nocache;

/* ê³µï¿½??ï¿½ï¿½?ï¿½ï¿½ ?ï¿½ï¿½???ï¿½ï¿½ ?ï¿½ï¿½?ï¿½ï¿½ */
create sequence seq_noticeno   
     start with 1    
     increment by 1  
     nomaxvalue     
     nocycle         
     nocache;

/* ?ï¿½ï¿½ë²¤íŠ¸ ?ï¿½ï¿½???ï¿½ï¿½ ?ï¿½ï¿½?ï¿½ï¿½ */
create sequence seq_eventno    
     start with 1    
     increment by 1  
     nomaxvalue     
     nocycle         
     nocache;

/* QNA  ?ï¿½ï¿½???ï¿½ï¿½ ?ï¿½ï¿½?ï¿½ï¿½ */
create sequence seq_qnano 
     start with 1    
     increment by 1  
     nomaxvalue     
     nocycle         
     nocache;

/* ?ï¿½ï¿½?ï¿½ï¿½êµ¬ë§¤?ï¿½ï¿½ê¸°ë¦¬ï¿?? ?ï¿½ï¿½???ï¿½ï¿½ ?ï¿½ï¿½?ï¿½ï¿½ */
create sequence seq_review_no  
     start with 1    
     increment by 1  
     nomaxvalue     
     nocycle         
     nocache;

/* ?ï¿½ï¿½ë°”êµ¬?ï¿½ï¿½ ?ï¿½ï¿½???ï¿½ï¿½ ?ï¿½ï¿½?ï¿½ï¿½ */
create sequence seq_cartno  
     start with 1    
     increment by 1  
     nomaxvalue     
     nocycle         
     nocache;

------------?ï¿½ï¿½???ï¿½ï¿½ ?ï¿½ï¿½?ï¿½ï¿½ ?ï¿½ï¿½-------

select *
  from user_sequences;

commit


select productnum, categorynum, productname, productimage1, productqty, productprice, fk_specnum, productcontent, point, userid
from
(
    select row_number() over(order by P.productnum desc)as RNO, productnum, categorynum, productname, productimage1, productqty, productprice, fk_specnum, productcontent, point, D.fk_userid as userid
    from tbl_product P
    JOIN tbl_dibs D
    ON P.productnum = D.fk_productnum
    where D.fk_userid = 'simyj'
) V
where V.RNO between 5 and 8;

select count(*)
from tbl_dibs
where fk_userid = 'simyj'

select *
from tbl_dibs

select *
from tbl_product

