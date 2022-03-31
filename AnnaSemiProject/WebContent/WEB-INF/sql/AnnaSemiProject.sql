<<<<<<< HEAD
show user;
-- USER?´(ê°?) "SEMIORAUSER2"?…?‹ˆ?‹¤.

grant connect, resource, create view, unlimited tablespace to SEMIORAUSER2;

select * from anna_test;

select * 
from tab;



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
/* ? œ?’ˆì¶”ê??´ë¯¸ì? */
CREATE TABLE tbl_product_imagefile (
	imagefilenum NUMBER NOT NULL, /* ?´ë¯¸ì?ë²ˆí˜¸ */
	fk_productnum NUMBER(8) NOT NULL, /* ? œ?’ˆë²ˆí˜¸ */
	imagefilename VARCHAR2(100) NOT NULL /* ?´ë¯¸ì??ŒŒ?¼ëª? */
);
=======
select table tbl_notice
>>>>>>> branch 'main' of https://github.com/Helenhyerim/AnnaSemiProject.git

drop table anna_test

select * from tbl_notice

<<<<<<< HEAD
/* ì¹´í…Œê³ ë¦¬ */
CREATE TABLE tbl_category (
	categorynum NUMBER(8) NOT NULL, /* ì¹´í…Œê³ ë¦¬??ë¶„ë¥˜ë²ˆí˜¸ */
	code VARCHAR2(20) NOT NULL, /* ì¹´í…Œê³ ë¦¬ì½”ë“œ */
	categoryname VARCHAR2(100) NOT NULL /* ì¹´í…Œê³ ë¦¬ëª? */
);
=======
SELECT * FROM COLS WHERE TABLE_NAME = 'tbl_notice'
>>>>>>> branch 'main' of https://github.com/Helenhyerim/AnnaSemiProject.git

insert into tbl_notice (noticeno, fk_userid, noticedate, noticetitle, noticecontents) 
values (seq_noticeno.nextval, 'admin', sysdate, '1ì›” ì¹´ë“œì‚¬ ë¬´ì´ì í• ë¶€ í˜œíƒì•ˆë‚´', 'ë‚´ìš©');

insert into tbl_notice (noticeno, fk_userid, noticedate, noticetitle, noticecontents) 
values (seq_noticeno.nextval, 'admin', sysdate, 'CJ ëŒ€í•œí†µìš´ íƒë°° íŒŒì—…ì— ë”°ë¥¸ ë°°ì†¡ì•ˆë‚´', 'ë‚´ìš©');

insert into tbl_notice (noticeno, fk_userid, noticedate, noticetitle, noticecontents) 
values (seq_noticeno.nextval, 'admin', sysdate, '2021 ì¶”ì„ì—°íœ´ ë°°ì†¡ì•ˆë‚´', 'ë‚´ìš©');

insert into tbl_notice (noticeno, fk_userid, noticedate, noticetitle, noticecontents) 
values (seq_noticeno.nextval, 'admin', sysdate, '2021 ì—¬ë¦„ íœ´ê°€ ë°°ì†¡ì•ˆë‚´', 'ë‚´ìš©');

<<<<<<< HEAD
/* ? œ?’ˆ?Š¤?™ */
CREATE TABLE tbl_spec (
	specnum NUMBER(8) NOT NULL, /* ?Š¤?™ë²ˆí˜¸ */
	specname VARCHAR2(100) NOT NULL /* ?Š¤?™ëª? */
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
/* ?¥ë°”êµ¬?‹ˆ */
CREATE TABLE tbl_cart (
	cartno NUMBER NOT NULL, /* ?¥ë°”êµ¬?‹ˆë²ˆí˜¸ */
	fk_userid VARCHAR2(20) NOT NULL, /* ?šŒ?›?•„?´?”” */
	fk_productnum NUMBER(8) NOT NULL, /* ? œ?’ˆë²ˆí˜¸ */
	orderqty NUMBER(4) DEFAULT 0, /* ì£¼ë¬¸?Ÿ‰ */
	registerday DATE DEFAULT sysdate /* ?…? ¥?¼? */
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

exec pcd_notice_insert('2021 ì—¬ë¦„ íœ´ê°€ ë°°ì†¡ì•ˆë‚´','ì—¬ë¦„ íœ´ê°€ ë°°ì†¡ì•ˆë‚´ ì—¬ë¦„ íœ´ê°€ ë°°ì†¡ì•ˆë‚´ì—¬ë¦„ íœ´ê°€ ë°°ì†¡ì•ˆë‚´ì—¬ë¦„ íœ´ê°€ ë°°ì†¡ì•ˆë‚´ì—¬ë¦„ íœ´ê°€ ë°°ì†¡ì•ˆë‚´ì—¬ë¦„ íœ´ê°€ ë°°ì†¡ì•ˆë‚´');
-- PL/SQL í”„ë¡œì‹œì €ê°€ ì„±ê³µì ìœ¼ë¡œ ì™„ë£Œë˜ì—ˆìŠµë‹ˆë‹¤.
exec pcd_notice_insert('CJ ëŒ€í•œí†µìš´ íƒë°° íŒŒì—…ì— ë”°ë¥¸ ë°°ì†¡ì•ˆë‚´','CJ ëŒ€í•œí†µìš´ íƒë°° íŒŒì—…ì— ë”°ë¥¸ ë°°ì†¡ì•ˆë‚´CJ ëŒ€í•œí†µìš´ íƒë°° íŒŒì—…ì— ë”°ë¥¸ ë°°ì†¡ì•ˆë‚´CJ ëŒ€í•œí†µìš´ íƒë°° íŒŒì—…ì— ë”°ë¥¸ ë°°ì†¡ì•ˆë‚´CJ ëŒ€í•œí†µìš´ íƒë°° íŒŒì—…ì— ë”°ë¥¸ ë°°ì†¡ì•ˆë‚´CJ ëŒ€í•œí†µìš´ íƒë°° íŒŒì—…ì— ë”°ë¥¸ ë°°ì†¡ì•ˆë‚´CJ ëŒ€í•œí†µìš´ íƒë°° íŒŒì—…ì— ë”°ë¥¸ ë°°ì†¡ì•ˆë‚´CJ ëŒ€í•œí†µìš´ íƒë°° íŒŒì—…ì— ë”°ë¥¸ ë°°ì†¡ì•ˆë‚´CJ ëŒ€í•œí†µìš´ íƒë°° íŒŒì—…ì— ë”°ë¥¸ ë°°ì†¡ì•ˆë‚´');

<<<<<<< HEAD
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

select *
  from user_sequences;
=======
commit
>>>>>>> branch 'main' of https://github.com/Helenhyerim/AnnaSemiProject.git
