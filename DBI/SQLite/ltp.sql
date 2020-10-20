.mode column
.head on

pragma foreign_keys = on;

-- DDL

drop table if exists ltp;
drop table if exists p;
drop table if exists l;
drop table if exists t;


create table l (
  lnr    varchar(2) not null primary key
, lname  varchar(6) not null
, rabatt decimal(3) not null
, stadt  varchar(6) not null
);


create table t (
  tnr    varchar(2)    not null primary key
, tname  varchar(6)    not null
, farbe  varchar(4)    not null
, preis  decimal(4, 2) not null
, stadt  varchar(6)    not null
);


create table p (
  pnr    varchar(2) not null primary key
, pname  varchar(6) not null
, stadt  varchar(6) not null
);


create table ltp (
  lnr    varchar(2) not null references l
, tnr    varchar(2) not null references t
, tnr    varchar(2) not null references p
, menge  decimal(4) not null
, primary key(lnr, tnr, pnr)
);


-- DML

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



-- DQL

select *
   from l
;

.print

select *
   from t
;

.print

select *
   from p
;

.print


-- Experimente
