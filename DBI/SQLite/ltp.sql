-- DDL

drop table if exists ltp;
drop table if exists p;
drop table if exists l;
drop table if exists t;
go


create table l (
  lnr    varchar(2) not null primary key
, lname  varchar(6) not null
, rabatt decimal(3) not null
, stadt  varchar(6) not null
);


create table t (
  tnr    varchar(2)    not null primary key
, tname  varchar(8)    not null
, farbe  varchar(4)    not null
, preis  decimal(4, 2) not null
, stadt  varchar(6)    not null
);


create table p (
  pnr    varchar(2) not null primary key
, pname  varchar(9) not null
, stadt  varchar(6) not null
);
go


create table ltp (
  lnr    varchar(2) not null references l
, tnr    varchar(2) not null references t
, pnr    varchar(2) not null references p
, menge  decimal(4) not null
, primary key(lnr, tnr, pnr)
);
go


create index idx_ltp_lnr
	  on ltp(lnr)
;


create index idx_ltp_tnr
	  on ltp(tnr)
;


create index idx_ltp_pnr
	  on ltp(pnr)
;
go


-- DML

begin transaction;

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

insert into p
   (pnr ,  pname     ,  stadt  )
values
   ('P1', 'Flugzeug' , 'Paris' )
,  ('P2', 'Schiff'   , 'Rom'   )
,  ('P3', 'Seilbahn' , 'Athen' )
,  ('P4', 'Schiff'   , 'Athen' )
,  ('P5', 'Eisenbahn', 'London')
,  ('P6', 'Flugzeug' , 'Oslo'  )
,  ('P7', 'Autobus'  , 'London') 
;

insert into ltp
   (lnr, tnr, pnr, menge)
values
   ('L1', 'T1', 'P1', 200)
,  ('L1', 'T1', 'P4', 700)
,  ('L2', 'T3', 'P1', 400)
,  ('L2', 'T3', 'P2', 200)
,  ('L2', 'T3', 'P3', 200)
,  ('L2', 'T3', 'P4', 500)
,  ('L2', 'T3', 'P5', 600)
,  ('L2', 'T3', 'P6', 400)
,  ('L2', 'T3', 'P7', 800)
,  ('L2', 'T5', 'P2', 100)
,  ('L3', 'T3', 'P1', 200)
,  ('L3', 'T4', 'P2', 500)
,  ('L4', 'T6', 'P3', 300)
,  ('L4', 'T6', 'P7', 300)
,  ('L5', 'T1', 'P4', 100)
,  ('L5', 'T2', 'P2', 200)
,  ('L5', 'T2', 'P4', 100)
,  ('L5', 'T3', 'P4', 200)
,  ('L5', 'T4', 'P4', 800)
,  ('L5', 'T5', 'P4', 400)
,  ('L5', 'T5', 'P5', 500)
,  ('L5', 'T5', 'P7', 100)
,  ('L5', 'T6', 'P2', 200)
,  ('L5', 'T6', 'P4', 500)
;

commit;
go


-- DQL

select *
   from l
;

select *
   from t
;



select *
   from p
;

select *
   from ltp
;

-- Experimente
