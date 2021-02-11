--s20170592


--DDL

--create database emp;
--go

use emp;
go


--Drop Tables

drop table if exists dept;
drop table if exists emp;
drop table if exists salgrade;
go


--Create Tables

create table dept (
	deptno  int primary key,
	dname	varchar(25),
	loc		varchar(25)
);
go


create table emp (
	empno		int primary key,
	ename		varchar(25),
	job			varchar(25),
	mgr			int,
	hiredate	varchar(15),
	sal			float,
	comm		float,
	deptno		int
);
go


create table salgrade (
	grade	int primary key,
	losal	float,
	hisal	float
);
go


--DML

begin transaction;

delete from salgrade;
delete from emp;
delete from dept;
go


--Insert

insert into dept
  (deptno	,	dname		,	loc			)
values
  (10		,	'Accounting',	'New York'	)	
, (20		,	'Research'  ,	'Dallas'	)
, (30		,	'Sales'		,	'Chicago'	)
, (40		,	'Operations',	'Boston'	)
;


insert into emp
  (empno,	ename	,	job			,	mgr ,	hiredate	,	sal		,	comm	,	deptno)
values
  (7369	,	'Smith'	,	'Clerk'		,	7902,	'1980-12-17',	800.00	,	null	,	20	  )
, (7499	,	'Allen'	,	'Salesman'	,	7698,	'1981-02-20',	1600.00	,	300.00	,	30	  )
, (7521	,	'Ward'	,	'Salesman'	,	7698,	'1981-02-22',	1250.00	,	500.00	,	30	  )
, (7566	,	'Jones'	,	'Manager'	,	7839,	'1981-04-02',	2075.00	,	null	,	20	  )
, (7654	,	'Martin',	'Salesman'	,	7698,	'1981-09-28',	1250.00	,	1400.00	,	30	  )
, (7698	,	'Blake'	,	'Manager'	,	7839,	'1981-05-01',	2850.00	,	null	,	30	  )
, (7782	,	'Clark'	,	'Manager'	,	7839,	'1981-06-09',	2450.00	,	null	,	10	  )
, (7788	,	'Scott'	,	'Analyst'	,	7566,	'1982-12-09',	3000.00	,	null	,	20	  )
, (7839	,	'King'	,	'President'	,	null,	'1981-11-17',	5000.00	,	null	,	10	  )
, (7844	,	'Turner',	'Salesman'	,	7698,	'1981-09-08',	1500.00	,	0.00	,	30	  )
, (7876	,	'Adams'	,	'Clerk'		,	7788,	'1983-01-12',	1100.00	,	null	,	20	  )
, (7900	,	'James'	,	'Clerk'		,	7698,	'1981-12-03',	950.00	,	null	,	30	  )
, (7902	,	'Ford'	,	'Analyst'	,	7566,	'1981-12-03',	3000.00	,	null	,	20	  )
, (7934	,	'Miller',	'Clerk'		,	7782,	'1982-01-23',	1300.00	,	null	,	10	  )
;


insert into salgrade
  (grade, losal		,	hisal	)
values
  (1	, 700.00	,	1200.00	)
, (2	, 1201.00	,	1400.00	)
, (3	, 1401.00	,	2000.00	)
, (4	, 2001.00	,	3000.00	)
, (5	, 3001.00	,	9999.00	)
;


commit;
go


-- Index

create index idx_dept_deptno
    on dept(deptno)
;
go


create index idx_emp_empno
    on emp(empno)
;
go


create index idx_salgrade_grade
    on salgrade(grade)
;
go


--SelfJoin
--s20170592
select e.empno,e.ename,m.ename 
  from emp e 
  join emp m 
    on e.mgr=m.empno 
go


--s20170592
select e.empno,e.ename,m.ename 
  from emp e 
  join emp m 
    on e.mgr=m.empno 
union 
select e.empno,e.ename,'' 
  from emp e 
 where e.mgr is null 
 order by e.ename
;


--ThetaJoin
--s20170592
select ename, sal, grade
  from emp
  join salgrade
    on sal between losal and hisal
;
go


--OuterJoin
--s20170592
select e.empno, e.ename
      ,coalesce(m.ename, '') ename_vorgesetzer
  from emp e 
  left join emp m 
    on e.mgr = m.empno
  order by e.ename
;
go

