create table tbl_Member(
	id varchar2(10) primary key, 
	name varchar2(10) not null, 
	pw varchar2(10) not null,
	age number(4) check(age<120), 
	email VARCHAR2(20)
)

select * from tbl_Member

update travelmember set name = 'Mac2020', age = 13 where id = 'm001'

SELECT * FROM board3

ALTER TABLE board3 RENAME COLUMN area TO location;


select * from (select rownum rnum, num, title, writer, location, writeday, readcnt, repIndent from (select * from board3 order by repRoot desc, repStep asc)) where location='강원'

commit
DROP TABLE tbl_board;
DROP TABLE tbl_location;
DROP TABLE tbl_Member

SELECT * FROM tbl_board;
SELECT * FROM tbl_location;

create table tbl_location(
locationCode number(6) default 1,
locationName varchar2(8)
)
alter table tbl_location add constraint pk_location_code primary key(locationCode)

CREATE TABLE tbl_board(
num number(8) not null,
writer varchar2(10) not null,
title varchar2(60) not null,
locationCode number(6),
content varchar2(1000),
writeday date default sysdate,
readcnt number(4) default 0,
repRoot number(4),
repStep number(4),
repIndent number(4)
);

alter table tbl_board add constraint pk_board_num primary key(num)
alter table tbl_board add constraint fk_board_location foreign key(locationCode) references tbl_location(locationCode)
alter table tbl_board add constraint fk_board_id foreign key(writer) references tbl_Member(id)

insert into TBL_BOARD
(num, writer, title, locationCode, content, repRoot, repStep, repIndent)
values
(1, 'test', 'show', 1, null, 1, 1, 1)

insert into tbl_location (locationCode, locationName) values (1, '기타')
insert into tbl_location (locationCode, locationName) values (2, '서울')
insert into tbl_location (locationCode, locationName) values (31, '경기')
insert into tbl_location (locationCode, locationName) values (32, '인천')
insert into tbl_location (locationCode, locationName) values (33, '강원')
insert into tbl_location (locationCode, locationName) values (41, '충남')
insert into tbl_location (locationCode, locationName) values (42, '대전')
insert into tbl_location (locationCode, locationName) values (43, '충북')
insert into tbl_location (locationCode, locationName) values (44, '세종')
insert into tbl_location (locationCode, locationName) values (51, '부산')
insert into tbl_location (locationCode, locationName) values (52, '울산')
insert into tbl_location (locationCode, locationName) values (53, '대구')
insert into tbl_location (locationCode, locationName) values (54, '경북')
insert into tbl_location (locationCode, locationName) values (55, '경남')
insert into tbl_location (locationCode, locationName) values (61, '전남')
insert into tbl_location (locationCode, locationName) values (62, '광주')
insert into tbl_location (locationCode, locationName) values (63, '전북')
insert into tbl_location (locationCode, locationName) values (64, '제주')

commit

// 조인 게시판 조회
select *
from tbl_board b
left join tbl_location l on b.locationCode = l.locationCode 
order by repRoot desc, repStep asc


select * from tbl_location where locationCode=1

-----------------------------------------------------------------
select * from 
(
	select rownum rnum, num, writer, writeday, title, 
		locationName, content, readcnt, repRoot, repStep, repIndent  from 
	(
		select *
		from tbl_board b
		left join tbl_location l on b.locationCode = l.locationCode 
		order by repRoot desc, repStep asc
	)
) 
where rnum >= 1 and rnum <= 3

----------------------------------------------------------------------
select * from 
(
	select rownum rnum, num, writer, writeday, title, 
		locationName, content, readcnt, repRoot, repStep, repIndent  from 
	(
		select *
		from tbl_board b
		left join tbl_location l on b.locationCode = l.locationCode 
		where b.num= 2
		order by repRoot desc, repStep asc
	)
)

et title=?, locationCode=?, content=? where num=?
-----------------------------------------------------------------------
select * from 
(
	select rownum rnum, num, writer, writeday, title,
		locationName, content, readcnt, repRoot, repStep, repIndent  from 
	(
		select *
		from tbl_board b
		left join tbl_location l on b.locationCode = l.locationCode 
		where b.locationCode like decode(64, 0, '%', 64)
		order by repRoot desc, repStep asc
	)
)
where b.num= 2
----------------------------------------------------------------------


update tbl_board set repStep = repStep+1 where repRoot=? and repStep>?

----------------------------------------------------------------------

insert into tbl_board (writeday) values (SELECT to_char(sysdate,'yyyy.MM.dd') FROM tbl_board);

select * from v$nls_parameters;