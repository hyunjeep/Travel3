create table tbl_Member(
	id varchar2(20) primary key, 
	name varchar2(10) not null, 
	pw varchar2(20) not null,
	age number(4) check(age<120), 
	email VARCHAR2(40)
)

create table tbl_location(
locationCode number(6) default 1,
locationName varchar2(8)
)
alter table tbl_location add constraint pk_location_code primary key(locationCode)
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
alter table tbl_board MODIFY content varchar2(3000)
alter table tbl_board add constraint pk_board_num primary key(num)
alter table tbl_board add constraint fk_board_location foreign key(locationCode) references tbl_location(locationCode)
alter table tbl_board add constraint fk_board_id foreign key(writer) references tbl_Member(id)

CREATE TABLE tbl_file(
fileNum number(8) not null,
fileName varchar2(40) not null,
orgFileName varchar2(40) not null,
fileUrl varchar2(100)
)
ALTER TABLE tbl_file MODIFY fileNum not null;
ALTER TABLE tbl_file MODIFY fileName not null;
ALTER TABLE tbl_file MODIFY orgFileName not null;
alter table tbl_file add constraint pk_file_fileNum primary key(fileNum)
alter table tbl_file add constraint fk_file_num foreign key(fileNum) references tbl_board(num)
ALTER TABLE tbl_file MODIFY fileName varchar2(60);
ALTER TABLE tbl_file MODIFY orgFileName varchar2(60);

select * from tbl_Member
select * from tbl_file
SELECT * FROM tbl_board
SELECT * FROM tbl_location;

commit

DROP TABLE tbl_board;
DROP TABLE tbl_location;
DROP TABLE tbl_Member
DROP TABLE tbl_file

// 조인 게시판 조회
select *
from tbl_board b
left join tbl_location l on b.locationCode = l.locationCode
left join tbl_file f on b.num = f.fileNum
order by repRoot desc, repStep asc

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


18151515

