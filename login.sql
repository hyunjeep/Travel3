create table tbl_Member(
	id varchar2(10) primary key, 
	name varchar2(10) not null, 
	pw varchar2(10) not null,
	age number(4) check(age<120), 
	email VARCHAR2(20)
)

select * from tbl_Member
select * from tbl_file

update travelmember set name = 'Mac2020', age = 13 where id = 'm001'

SELECT * FROM board3

ALTER TABLE board3 RENAME COLUMN area TO location;
ALTER TABLE tbl_file MODIFY fileName varchar2(60);
ALTER TABLE tbl_file MODIFY orgFileName varchar2(60);

select * from (select rownum rnum, num, title, writer, location, writeday, readcnt, repIndent from (select * from board3 order by repRoot desc, repStep asc)) where location='강원'

commit
DROP TABLE tbl_board;
DROP TABLE tbl_location;
DROP TABLE tbl_Member
DROP TABLE tbl_file

SELECT * FROM tbl_board;
SELECT * FROM tbl_location;
SELECT * FROM tbl_file;

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
ALTER TABLE tbl_board DROP COLUMN fileName;
ALTER TABLE tbl_board ADD fileName VARCHAR2(24);
alter table tbl_board add constraint pk_board_num primary key(num)
alter table tbl_board add constraint fk_board_location foreign key(locationCode) references tbl_location(locationCode)
alter table tbl_board add constraint fk_board_id foreign key(writer) references tbl_Member(id)

CREATE TABLE tbl_file(
fileNum number(8) not null,
fileName varchar2(20) not null,
orgFileName varchar2(20) not null,
fileUrl varchar2(100)
)
alter table tbl_file add constraint pk_file_fileNum primary key(fileNum)
alter table tbl_file add constraint fk_file_num foreign key(fileNum) references tbl_board(num)

insert into TBL_BOARD
(num, writer, title, locationCode, content, repRoot, repStep, repIndent)
values
(1, 'test', 'show', 1, null, 1, 1, 1)

insert into tbl_location (locationCode, locationName) values (0, '전체')
insert into tbl_location (locationCode, locationName) values (99, '기타')
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

update tbl_location set locationCode=99 where locationName='기타';
commit

// 조인 게시판 조회
select *
from tbl_board b
left join tbl_location l on b.locationCode = l.locationCode
left join tbl_file f on b.num = f.fileNum
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
		locationName, content, readcnt, repRoot, repStep, repIndent, fileNum, fileName, fileUrl from 
	(
		select *
		from tbl_board b
		left join tbl_location l on b.locationCode = l.locationCode 
		left join tbl_file f on b.num = f.fileNum
		order by repRoot desc, repStep asc
	)
)
		where b.num= 2
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
select fileNum from tbl_file

update tbl_board set repStep = repStep+1 where repRoot=? and repStep>?

----------------------------------------------------------------------

insert into tbl_board (writeday) values (SELECT to_char(sysdate,'yyyy.MM.dd') FROM tbl_board);

select * from v$nls_parameters;

select * from tbl_board b left join tbl_location l on b.locationCode = l.locationCode left join tbl_file f on b.num = f.fileNum where num=3 order by repRoot desc, repStep asc

update 
(select * from tbl_board b, tbl_file f where b.num = f.fileNum) set title=?, locationCode=?, content=?, fileName=?, orgFileName=?, fileUrl=? where num=?

update (select title, locationCode, content, fileName, orgFileName, fileUrl from tbl_board b left join tbl_file f on b.num = f.fileNum) set title=?, locationCode=?, content=? where num=?
select fileName from tbl_file where fileNum is not null

select * from tbl_file WHERE fileUrl IS NULL
select * from tbl_board b left join tbl_file f on b.num = f.fileNum

select num, fileNum, fileName from tbl_board b left join tbl_file f on b.num = f.fileNum