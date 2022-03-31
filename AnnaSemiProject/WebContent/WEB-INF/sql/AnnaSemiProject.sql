show user;
-- USER?ù¥(Í∞?) "SEMIORAUSER2"?ûÖ?ãà?ã§.

grant connect, resource, create view, unlimited tablespace to SEMIORAUSER2;

select * from anna_test;

select * 
from tab;



------------------------

/* ?†ú?íà */
CREATE TABLE tbl_product (
	productnum NUMBER(8) NOT NULL, /* ?†ú?íàÎ≤àÌò∏ */
	categorynum NUMBER(8) NOT NULL, /* Ïπ¥ÌÖåÍ≥†Î¶¨??Î∂ÑÎ•òÎ≤àÌò∏ */
	productname VARCHAR2(100) NOT NULL, /* ?†ú?íàÎ™? */
	productcompany VARCHAR2(50), /* ?†úÏ°∞Ìöå?Ç¨Î™? */
	productimage1 VARCHAR2(100), /* ???ëú?†ú?íà?ù¥ÎØ∏Ï?1 */
	productimage2 VARCHAR2(100), /* ???ëú?†ú?íà?ù¥ÎØ∏Ï?2 */
	productqty NUMBER(8) DEFAULT 0, /* ?†ú?íà?û¨Í≥†Îüâ */
	productprice NUMBER(8) DEFAULT 0, /* ?†ú?íà?†ïÍ∞? */
	saleprice NUMBER(8) DEFAULT 0, /* ?†ú?íà?åêÎß§Í? */
	fk_specnum NUMBER(8), /* ?ä§?éôÎ≤àÌò∏ */
	productcontent VARCHAR2(4000), /* ?†ú?íà?Ñ§Î™? */
	point NUMBER(8) DEFAULT 0, /* ?†ÅÎ¶ΩÍ∏à */
	productinputdate DATE DEFAULT sysdate /* ?†ú?íà?ûÖÍ≥†Ïùº?ûê */
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

/* ?†ú?íàÏ∂îÍ??ù¥ÎØ∏Ï? */
CREATE TABLE tbl_product_imagefile (
	imagefilenum NUMBER NOT NULL, /* ?ù¥ÎØ∏Ï?Î≤àÌò∏ */
	fk_productnum NUMBER(8) NOT NULL, /* ?†ú?íàÎ≤àÌò∏ */
	imagefilename VARCHAR2(100) NOT NULL /* ?ù¥ÎØ∏Ï??åå?ùºÎ™? */
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

/* Ïπ¥ÌÖåÍ≥†Î¶¨ */
CREATE TABLE tbl_category (
	categorynum NUMBER(8) NOT NULL, /* Ïπ¥ÌÖåÍ≥†Î¶¨??Î∂ÑÎ•òÎ≤àÌò∏ */
	code VARCHAR2(20) NOT NULL, /* Ïπ¥ÌÖåÍ≥†Î¶¨ÏΩîÎìú */
	categoryname VARCHAR2(100) NOT NULL /* Ïπ¥ÌÖåÍ≥†Î¶¨Î™? */
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

/* ?†ú?íà?ä§?éô */
CREATE TABLE tbl_spec (
	specnum NUMBER(8) NOT NULL, /* ?ä§?éôÎ≤àÌò∏ */
	specname VARCHAR2(100) NOT NULL /* ?ä§?éôÎ™? */
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

/* ?û•Î∞îÍµ¨?ãà */
CREATE TABLE tbl_cart (
	cartno NUMBER NOT NULL, /* ?û•Î∞îÍµ¨?ãàÎ≤àÌò∏ */
	fk_userid VARCHAR2(20) NOT NULL, /* ?öå?õê?ïÑ?ù¥?îî */
	fk_productnum NUMBER(8) NOT NULL, /* ?†ú?íàÎ≤àÌò∏ */
	orderqty NUMBER(4) DEFAULT 0, /* Ï£ºÎ¨∏?üâ */
	registerday DATE DEFAULT sysdate /* ?ûÖ?†•?ùº?ûê */
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

/* Ï∞úÌïòÍ∏? */
CREATE TABLE tbl_dibs (
	fk_productnum NUMBER(8) NOT NULL, /* ?†ú?íàÎ≤àÌò∏ */
	fk_userid VARCHAR2(20) NOT NULL /* ?öå?õê?ïÑ?ù¥?îî */
);

/* Í≥µÏ??Ç¨?ï≠ */
CREATE TABLE tbl_notice (
	noticeno NUMBER NOT NULL, /* Í≥µÏ??Ç¨?ï≠Î≤àÌò∏ */
	fk_userid VARCHAR2(20) NOT NULL, /* ?öå?õê?ïÑ?ù¥?îî */
	noticedate DATE DEFAULT sysdate NOT NULL, /* ?ûë?Ñ±?ùº?ûê */
	noticetitle VARCHAR2(100) NOT NULL, /* Í∏??†úÎ™? */
	noticecontents VARCHAR2(4000) NOT NULL /* Í∏??Ç¥?ö© */
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

/* ?ù¥Î≤§Ìä∏ */
CREATE TABLE tbl_event (
	eventno NUMBER NOT NULL, /* ?ù¥Î≤§Ìä∏Î≤àÌò∏ */
	userid VARCHAR2(20) NOT NULL, /* ?öå?õê?ïÑ?ù¥?îî */
	eventdate DATE DEFAULT sysdate NOT NULL, /* ?ûë?Ñ±?ùº?ûê */
	eventtitle VARCHAR2(100) NOT NULL, /* Í∏??†úÎ™? */
	eventcontents VARCHAR2(4000) NOT NULL, /* Í∏??Ç¥?ö© */
	imagefilename VARCHAR2(100), /* ?ù¥ÎØ∏Ï? */
	eventstartdate DATE NOT NULL, /* ?ù¥Î≤§Ìä∏?ãú?ûë?ùº */
	eventenddate DATE /* ?ù¥Î≤§Ìä∏Ï¢ÖÎ£å?ùº */
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

/* ?†ú?íàÍµ¨Îß§?õÑÍ∏∞Î¶¨Î∑? */
CREATE TABLE tbl_purchase_reviews (
	review_no NUMBER NOT NULL, /* ?ûë?Ñ±Î≤àÌò∏ */
	fk_userid VARCHAR2(20) NOT NULL, /* ?öå?õê?ïÑ?ù¥?îî */
	fk_productnum NUMBER(8) NOT NULL, /* ?†ú?íàÎ≤àÌò∏ */
	reviewcontents VARCHAR2(4000) NOT NULL, /* Î¶¨Î∑∞?Ç¥?ö© */
	reviewdate DATE DEFAULT sysdate /* ?ûë?Ñ±?ùº?ûê */
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
	faqno NUMBER NOT NULL, /* FAQÎ≤àÌò∏ */
	fk_userid VARCHAR2(20) NOT NULL, /* ?öå?õê?ïÑ?ù¥?îî */
	faqrequesttype VARCHAR2(20) NOT NULL, /* Î¨∏ÏùòÎ∂ÑÎ•ò */
	faqtitle VARCHAR2(100) NOT NULL, /* Í∏??†úÎ™? */
	faqcontents VARCHAR2(4000) NOT NULL /* Í∏??Ç¥?ö© */
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
	qnano NUMBER NOT NULL, /* QnAÎ≤àÌò∏ */
	fk_userid VARCHAR2(20) NOT NULL, /* ?öå?õê?ïÑ?ù¥?îî */
	questiontitle VARCHAR2(100) NOT NULL, /* ÏßàÎ¨∏?†úÎ™? */
	questioncontents VARCHAR2(4000) NOT NULL, /* ÏßàÎ¨∏?Ç¥?ö© */
	questiondate DATE DEFAULT sysdate NOT NULL, /* ÏßàÎ¨∏?ûë?Ñ±?ùº?ûê */
	answertitle VARCHAR2(100), /* ?ãµÎ≥??†úÎ™? */
	answercontents VARCHAR2(4000), /* ?ãµÎ≥??Ç¥?ö© */
	answerdate DATE DEFAULT sysdate /* ?ãµÎ≥??ûë?Ñ±?ùº?ûê */
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

/* Î°úÍ∑∏?ù∏Í∏∞Î°ù */
CREATE TABLE tbl_loginhistory (
	fk_userid VARCHAR2(20), /* ?öå?õê?ïÑ?ù¥?îî */
	logindate DATE DEFAULT sysdate NOT NULL, /* Î°úÍ∑∏?ù∏?Ç†ÏßúÏãúÍ∞? */
	clientip VARCHAR2(20) /* ?†ë?ÜçIPÏ£ºÏÜå */
);

/* ?öå?õê */
CREATE TABLE tbl_member (
	userid VARCHAR2(20) NOT NULL, /* ?öå?õê?ïÑ?ù¥?îî */
	pwd VARCHAR2(200) NOT NULL, /* ?öå?õêÎπÑÎ?Î≤àÌò∏ */
	name VARCHAR2(30) NOT NULL, /* ?öå?õêÎ™? */
	email VARCHAR2(200) NOT NULL, /* ?ù¥Î©îÏùº */
	mobile VARCHAR2(200), /* ?ú¥???è∞Î≤àÌò∏ */
	postcode VARCHAR2(10), /* ?ö∞?é∏Î≤àÌò∏ */
	address VARCHAR2(200), /* Ï£ºÏÜå */
	detailaddress VARCHAR2(200), /* ?ÉÅ?Ñ∏Ï£ºÏÜå */
	gender VARCHAR2(1), /* ?Ñ±Î≥? */
	birthday VARCHAR2(10), /* ?Éù?ÖÑ?õî?ùº */
	point NUMBER DEFAULT 0, /* ?†ÅÎ¶ΩÍ∏à */
	registerday DATE DEFAULT sysdate, /* Í∞??ûÖ?ùº?ûê */
	lastpwdchangedate DATE DEFAULT sysdate, /* ÎßàÏ?ÎßâÏïî?ò∏Î≥?Í≤ΩÎÇ†ÏßúÏãúÍ∞? */
	register_status NUMBER(1) DEFAULT 1 NOT NULL, /* ?öå?õê?Éà?á¥?ó¨Î∂? */
	inactive_status NUMBER(1) DEFAULT 0 NOT NULL, /* ?ú¥Î©¥Ïó¨Î∂? */
	sms_status NUMBER(1) NOT NULL, /* SMS?àò?ã†?èô?ùò?ó¨Î∂? */
	email_status NUMBER(1) NOT NULL /* ?ù¥Î©îÏùº?àò?ã†?èô?ùò?ó¨Î∂? */
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

/* ?õÑÍ∏∞Ï¢ã?ïÑ?öî */
CREATE TABLE tbl_review_like (
	fk_review_no NUMBER NOT NULL, /* ?õÑÍ∏∞Î≤à?ò∏ */
	fk_userid VARCHAR2(20) NOT NULL /* ?öå?õê?ïÑ?ù¥?îî */
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

/* Ï£ºÎ¨∏?ÉÅ?Ñ∏ */
CREATE TABLE tbl_orderdetail (
	orderseqnum NUMBER NOT NULL, /* Ï£ºÎ¨∏?ÉÅ?Ñ∏?ùº?†®Î≤àÌò∏ */
	fk_productnum NUMBER(8) NOT NULL, /* ?†ú?íàÎ≤àÌò∏ */
	ordernum VARCHAR2(20) NOT NULL, /* Ï£ºÎ¨∏ÏΩîÎìú */
	orderqty NUMBER NOT NULL, /* Ï£ºÎ¨∏?üâ */
	orderprice NUMBER NOT NULL, /* Ï£ºÎ¨∏Í∞?Í≤? */
	deliverstatus NUMBER(1) DEFAULT 1 NOT NULL, /* Î∞∞ÏÜ°?ÉÅ?Éú */
	deliverdate DATE /* Î∞∞ÏÜ°?ôÑÎ£åÏùº?ûê */
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

/* Ï£ºÎ¨∏ */
CREATE TABLE tbl_order (
	ordernum VARCHAR2(20) NOT NULL, /* Ï£ºÎ¨∏ÏΩîÎìú */
	fk_userid VARCHAR2(20) NOT NULL, /* ?öå?õê?ïÑ?ù¥?îî(Ï£ºÎ¨∏?ïò?ãú?äîÎ∂?) */
	ordertotalprice NUMBER NOT NULL, /* Ï£ºÎ¨∏Ï¥ùÏï° */
	ordertotalpoint NUMBER(8) NOT NULL, /* Ï£ºÎ¨∏Ï¥ùÌè¨?ù∏?ä∏ */
	orderdate DATE DEFAULT sysdate NOT NULL, /* Ï£ºÎ¨∏?ùº?ûê */
	paymethod NUMBER(1), /* Í≤∞Ï†ú?àò?ã® */
	name_receiver VARCHAR2(30), /* Î∞õÏúº?ãú?äîÎ∂? */
	zipcode VARCHAR2(100), /* ?ö∞?é∏Î≤àÌò∏ */
	address VARCHAR2(200) /* Î∞∞ÏÜ°Ïß?Ï£ºÏÜå */
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
        
        
------------?ãú???ä§ ?Éù?Ñ± ?ãú?ûë-------

/* FAQ ?ãú???ä§ ?Éù?Ñ± */
     create sequence seq_faqno   
     start with 1    
     increment by 1  
     nomaxvalue     
     nocycle         
     nocache;

/* Í≥µÏ??Ç¨?ï≠ ?ãú???ä§ ?Éù?Ñ± */
create sequence seq_noticeno   
     start with 1    
     increment by 1  
     nomaxvalue     
     nocycle         
     nocache;

/* ?ù¥Î≤§Ìä∏ ?ãú???ä§ ?Éù?Ñ± */
create sequence seq_eventno    
     start with 1    
     increment by 1  
     nomaxvalue     
     nocycle         
     nocache;

/* QNA  ?ãú???ä§ ?Éù?Ñ± */
create sequence seq_qnano 
     start with 1    
     increment by 1  
     nomaxvalue     
     nocycle         
     nocache;

/* ?†ú?íàÍµ¨Îß§?õÑÍ∏∞Î¶¨Î∑? ?ãú???ä§ ?Éù?Ñ± */
create sequence seq_review_no  
     start with 1    
     increment by 1  
     nomaxvalue     
     nocycle         
     nocache;

/* ?û•Î∞îÍµ¨?ãà ?ãú???ä§ ?Éù?Ñ± */
create sequence seq_cartno  
     start with 1    
     increment by 1  
     nomaxvalue     
     nocycle         
     nocache;

------------?ãú???ä§ ?Éù?Ñ± ?Åù-------

select *
  from user_sequences;