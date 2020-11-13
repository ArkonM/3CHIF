-- DDL

--create database schulungsfirma;
--go

use schulungsfirma;
go

set nocount on


drop table if exists besucht;
drop table if exists kveranst;
drop table if exists geeignet;
drop table if exists setztvor;
drop table if exists referent;
drop table if exists person;
drop table if exists kurs;
go


create table person
(
  pnr      integer     not null primary key
, fname    varchar(16) not null
, vname    varchar(16) not null
, ort      varchar(10) not null
, land     varchar(3)  not null
,  CHECK (land = 'A'  OR
		  land = 'I'  OR
		  land = 'GB' OR 
		  land = 'F'  OR 
		  land = 'D'  OR
		  land = 'RUS' )
);
go

create table referent
(
  pnr      integer    not null primary key references person
, gebdat   date       not null
, seit     date       not null
, titel    varchar(6)
, CHECK (gebdat < seit)
);
go


create table kurs
(
  knr      integer       not null primary key
, bezeichn varchar(20)   not null
, tage     integer		 not null
, preis    decimal(6, 2) not null
, unique(knr, tage)
, CHECK (tage between 1 and 10)
);
go


create table setztvor
(
  knr      integer not null references kurs
, knrvor   integer not null references kurs
, primary key(knr, knrvor)
);
go


create table geeignet
(
  knr      integer not null references kurs(knr)
, pnr      integer not null references referent(pnr)
, primary key(knr, pnr)
);
go



create table kveranst
(
  knr      integer     not null references kurs(knr)
, knrlfnd  integer     not null
, von      date        not null
, bis      date
, ort      varchar(10) not null
, plaetze  integer     not null
, pnr      integer				references referent(pnr)  -- kann NULL sein
, CHECK (von <= bis OR bis = NULL)
, primary key(knr, knrlfnd)
);
go


create table besucht
(
  knr      integer not null
, knrlfnd  integer not null
, pnr      integer not null references person(pnr)
, bezahlt  date
, primary key(knr, knrlfnd, pnr)
, foreign key(knr, knrlfnd) references kveranst
);
go

-- DML

begin transaction;

delete from person;
delete from kurs;
delete from setztvor;
delete from referent;
delete from geeignet;
delete from kveranst;
delete from besucht;
go

set dateformat dmy;


insert into person
  (pnr, fname,           vname,               ort,        land)
values
  (101, 'Bach'         , 'Johann Sebastian',  'Leipzig'  , 'D'  )
, (102, 'Händel'       , 'Georg Friedrich' ,  'London'   , 'GB' )
, (103, 'Haydn'        , 'Joseph'          ,  'Wien'     , 'A'  )
, (104, 'Mozart'       , 'Wolfgang Amadeus',  'Wien'     , 'A'  )
, (105, 'Beethoven'    , 'Ludwig van'      ,  'Wien'     , 'A'  )
, (106, 'Schubert'     , 'Franz'           ,  'Wien'     , 'A'  )
, (107, 'Berlioz'      , 'Hector'          ,  'Paris'    , 'F'  )
, (108, 'Listz'        , 'Franz'           ,  'Wien'     , 'A'  )
, (109, 'Wagner'       , 'Richard'         ,  'München'  , 'D'  )
, (110, 'Verdi'        , 'Guiseppe'        ,  'Busseto'  , 'I'  )
, (111, 'Bruckner'     , 'Anton'           ,  'Linz'     , 'A'  )
, (112, 'Brahms'       , 'Johannes'        ,  'Wien'     , 'A'  )
, (113, 'Bizet'        , 'Georges'         ,  'Paris'    , 'F'  )
, (114, 'Tschaikowskij', 'Peter'           ,  'Moskau'   , 'RUS')
, (115, 'Puccini'      , 'Giacomo'         ,  'Mailand'  , 'I'  )
, (116, 'Strauss'      , 'Richard'         ,  'München'  , 'D'  )
, (117, 'Schönberg'    , 'Arnold'          ,  'Wien'     , 'A'  )
;

insert into referent
  (pnr, gebdat,       seit,         titel )
values
  (101, '21.03.1935', '01.01.1980',  null )
, (103, '01.04.1932', '01.01.1991',  null )
, (104, '27.01.1956', '01.07.1987',  null )
, (111, '04.09.1924', '01.07.1990',  'Mag')
, (114, '25.04.1940', '01.07.1980',  null )
, (116, '11.06.1964', '01.01.1994',  'Dr' )
;

insert into kurs
  (knr, bezeichn,         tage,   preis)
values
  (  1, 'Notenkunde'       ,     2, 1400.00)
, (  2, 'Harmonielehre'    ,     3, 2000.00)
, (  3, 'Rythmik'          ,     1,  700.00)
, (  4, 'Instrumentenkunde',     2, 1500.00)
, (  5, 'Dirigieren'       ,     3, 1900.00)
, (  6, 'Musikgeschichte'  ,     2, 1400.00)
, (  7, 'Komposition'      ,     4, 3000.00)
;

insert into setztvor
  (knr, knrvor)
values
  (  2,      1)
, (  3,      1)
, (  5,      2)
, (  5,      3)
, (  5,      4)
, (  7,      5)
, (  7,      6)
;

insert into geeignet
  (knr, pnr)
values
  (  1, 103)
, (  1, 114)
, (  2, 104)
, (  2, 111)
, (  3, 103)
, (  4, 104)
, (  5, 101)
, (  5, 114)
, (  6, 111)
, (  7, 103)
, (  7, 116)
;

insert into kveranst
  (knr, knrlfnd, von         , bis         , ort      , plaetze,  pnr)
values
  (  1,       1, '07.04.2003', '08.04.2003', 'Wien'   ,        3,   103)
, (  1,       2, '23.06.2004', '24.06.2004', 'Moskau' ,        4,   114)
, (  1,       3, '10.04.2005', '11.04.2005', 'Paris'  ,        3,  null)
, (  2,       1, '09.10.2003', '11.10.2003', 'Wien'   ,        4,   104)
, (  3,       1, '17.11.2003', '17.11.2003', 'Moskau' ,        3,   103)
, (  4,       1, '12.01.2004', '13.01.2004', 'Wien'   ,        2,   116)
, (  4,       2, '28.03.2004', '29.03.2004', 'Wien'   ,        4,   104)
, (  5,       1, '18.05.2004', '20.05.2004', 'Paris'  ,        3,   101)
, (  5,       2, '23.09.2004', '26.09.2004', 'Wien'   ,        2,   101)
, (  5,       3, '30.03.2005', '01.04.2005', 'Rom'    ,        3,  null)
, (  7,       1, '09.03.2005', '13.03.2005', 'Wien'   ,        5,   103)
, (  7,       2, '14.09.2005', '18.09.2005', 'München',        4,   116)
;

insert into besucht
  (knr, knrlfnd, pnr,      bezahlt)
values
  (  1,       1, 108, '01.05.2003')
, (  1,       1, 109,         null)
, (  1,       1, 114,         null)
, (  1,       2, 110, '01.07.2004')
, (  1,       2, 112, '03.07.2004')
, (  1,       2, 113, '20.07.2004')
, (  1,       2, 116,         null)
, (  1,       3, 110,         null)
, (  2,       1, 105, '15.10.2003')
, (  2,       1, 109, '03.11.2003')
, (  2,       1, 112, '28.10.2003')
, (  2,       1, 116,         null)
, (  3,       1, 101,         null)
, (  3,       1, 109,         null)
, (  3,       1, 117, '20.11.2003')
, (  4,       1, 102, '20.01.2004')
, (  4,       1, 107, '01.02.2004')
, (  4,       1, 111,         null)
, (  4,       2, 106, '07.04.2004')
, (  4,       2, 109, '15.04.2004')
, (  5,       1, 103,         null)
, (  5,       1, 109, '07.06.2004')
, (  5,       2, 115, '07.10.2004')
, (  5,       2, 116,         null)
, (  7,       1, 109, '20.03.2005')
, (  7,       1, 113,         null)
, (  7,       1, 117, '09.04.2005')
;

commit;
go

-- create index


create index idx_referent_pnr
		  on referent(pnr)
;
go

create index idx_setztvor_knr
		  on setztvor(knr)
;
go

create index idx_setztvor_knrvor
		  on setztvor(knrvor)
;
go

create index idx_geeignet_knr
		  on geeignet(knr)
;
go

create index idx_geeignet_pnr
		  on geeignet(pnr)
;
go

create index idx_kveranst_knr
		  on kveranst(knr)
;
go

create index idx_kveranst_knrlfnd
		  on kveranst(knrlfnd)
;
go

create index idx_besucht_knr
		  on besucht(knr)
;
go

create index idx_besucht_knrlfnd
		  on besucht(knrlfnd)
;
go

create index idx_besucht_pnr
		  on besucht(pnr)
;
go


select *
  from person
 order by pnr
;
go

select *
  from referent
 order by pnr
;
go

select *
  from kurs
 order by knr
;
go

select *
  from geeignet
 order by pnr
;
go

select *
  from setztvor
 order by knr
;
go

select *
  from kveranst
 order by knr
;
go

select *
  from besucht
 order by knr
;
go