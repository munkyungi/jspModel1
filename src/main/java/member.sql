
drop table member;

create table member(
	id varchar(50) primary key,
	pwd varchar(50) not null,
	name varchar(50) not null,
	email varchar(50) unique,
	auth int
);

-- boolean --
select id
from member
where id='abc';

-- count --
select count(*)
from member
where id='abc';

select * from member;

delete from member where id="poi";