/*
create database lt;
go

use lt;
go
*/

-- DDL

drop table if exists lt;
drop table if exists l;
drop table if exists t;
go


create table l (
  lnr    varchar(2) not null primary key
, lname  varchar(8) not null
, rabatt decimal(3) not null
, stadt  varchar(6) not null
);
go


create table t (
  tnr    varchar(2)    not null primary key
, tname  varchar(8)    not null
, farbe  varchar(4)    not null
, preis  decimal(4, 2) not null
, stadt  varchar(6)    not null
);
go


create table lt (
  lnr     varchar(2) not null references l
, tnr     varchar(2) not null references t
, menge   decimal(4) not null
, ankunft datetime	 not null
, primary key(lnr, tnr)
);
go


create index idx_lt_lnr
	  on lt(lnr)
;


create index idx_lt_tnr
	  on lt(tnr)
;


-- DML

begin transaction;

delete from lt;
delete from t;
delete from l;

insert into l
   (lnr , lname   , rabatt,  stadt   )
values
   ('L1', 'Schmid',     20, 'London' )
,  ('L2', 'Jonas' ,     10, 'Paris'  )
,  ('L3', 'Berger',     30, 'Paris'  )
,  ('L4', 'Klein' ,     20, 'London' )
,  ('L5', 'Adam'  ,     30, 'Athen'  )
;

insert into t
   (tnr ,  tname     ,  farbe  , preis,  stadt   )
values
   ('T1', 'Mutter'   , 'rot'   ,    12, 'London' )
,  ('T2', 'Bolzen'   , 'gelb'  ,    17, 'Paris'  )
,  ('T3', 'Schraube' , 'blau'  ,    17, 'Rom'    )
,  ('T4', 'Schraube' , 'rot'   ,    14, 'London' )
,  ('T5', 'Welle'    , 'blau'  ,    12, 'Paris'  )
,  ('T6', 'Zahnrad'  , 'rot'   ,    19, 'London' )
;

insert into lt
   (lnr ,  tnr , menge, ankunft)
values
   ('L1', 'T1' ,   300, '2021-04-01')
,  ('L1', 'T2' ,   200, '2020-11-22')
,  ('L1', 'T3' ,   400, '2020-09-13')
,  ('L1', 'T4' ,   200, '2020-05-28')
,  ('L1', 'T5' ,   100, '2020-01-09')
,  ('L1', 'T6' ,   100, '2020-03-03')
,  ('L2', 'T1' ,   300, '2020-07-17')
,  ('L2', 'T2' ,   400, '2020-03-14')
,  ('L3', 'T2' ,   200, '2020-10-23')
,  ('L4', 'T2' ,   200, '2020-03-20')
,  ('L4', 'T4' ,   300, '2020-04-02')
,  ('L4', 'T5' ,   400, '2020-05-18')
;

commit;
go

-- DQL

select 
  datediff(dd, ankunft, getdate()) "diff"
  from lt
;
go

datetime

-- schneider.armin@student.htlwrn.ac.at