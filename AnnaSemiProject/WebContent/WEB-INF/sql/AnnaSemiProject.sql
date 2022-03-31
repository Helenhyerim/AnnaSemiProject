create table anna_test
(seq          number
,name         varchar2(20) not null 
);
rollback
show user

select * from anna_test

INSERT into anna_test (seq, name)  values (1, 'choi');

select table tbl_notice

drop table anna_test

select * from tbl_notice

SELECT * FROM COLS WHERE TABLE_NAME = 'tbl_notice'

insert into tbl_notice (noticeno, fk_userid, noticedate, noticetitle, noticecontents) 
values (seq_noticeno.nextval, 'admin', sysdate, '1월 카드사 무이자 할부 혜택안내', '내용');

insert into tbl_notice (noticeno, fk_userid, noticedate, noticetitle, noticecontents) 
values (seq_noticeno.nextval, 'admin', sysdate, 'CJ 대한통운 택배 파업에 따른 배송안내', '내용');

insert into tbl_notice (noticeno, fk_userid, noticedate, noticetitle, noticecontents) 
values (seq_noticeno.nextval, 'admin', sysdate, '2021 추석연휴 배송안내', '내용');

insert into tbl_notice (noticeno, fk_userid, noticedate, noticetitle, noticecontents) 
values (seq_noticeno.nextval, 'admin', sysdate, '2021 여름 휴가 배송안내', '내용');


select * from user_sequences

insert into tbl_member(userid, pwd, name, email, sms_status, email_status)
values ('admin', 'qwer1234$', 'admin', 'admin@gmail.com', 1, 1)

commit

select * from tbl_member
select * from tbl_notice

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

exec pcd_notice_insert('2021 여름 휴가 배송안내','여름 휴가 배송안내 여름 휴가 배송안내여름 휴가 배송안내여름 휴가 배송안내여름 휴가 배송안내여름 휴가 배송안내');
-- PL/SQL 프로시저가 성공적으로 완료되었습니다.
exec pcd_notice_insert('CJ 대한통운 택배 파업에 따른 배송안내','CJ 대한통운 택배 파업에 따른 배송안내CJ 대한통운 택배 파업에 따른 배송안내CJ 대한통운 택배 파업에 따른 배송안내CJ 대한통운 택배 파업에 따른 배송안내CJ 대한통운 택배 파업에 따른 배송안내CJ 대한통운 택배 파업에 따른 배송안내CJ 대한통운 택배 파업에 따른 배송안내CJ 대한통운 택배 파업에 따른 배송안내');

commit