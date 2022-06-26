drop table if exists College;
drop table if exists Student;
drop table if exists Apply;

create table College(cName char(32) primary key, state char(16), enrollment int);
create table Student(sID int primary key, sName char(32), GPA decimal(5,1), sizeHS int);
create table Apply(sID int, cName char(32), major char(32), decision char(8),primary key (sID,cName,major));
