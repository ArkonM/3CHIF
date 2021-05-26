--DDL
--create database gebrein
use gebrein
go


set nocount on


	drop table if exists reinigt;
	drop table if exists raum;
	drop table if exists pfleger;
	drop table if exists typ;
	drop table if exists gebaeude;
go


create table gebaeude (
  gebcode  varchar(1)   not null  primary key
, gebadr   varchar(24)  not null
);
go


create table typ (
  sitztyp	varchar(1)	not null  primary key
, pflege	varchar(24) not null
);
go


create table raum (
  raumnr   integer	   not null
, gebcode  varchar(1)  not null	 references gebaeude
, sitzanz  integer	   not null
, sitztyp  varchar(1)  not null	 references typ
, primary key(raumnr, gebcode)
);
go


create table pfleger (
  pflgnr	 varchar(3)	  not null  primary key
, pflgrname  varchar(24)  not null
);
go


create table reinigt (
  raumnr   integer	    not null
, gebcode  varchar(1)	not null
, pflgnr   varchar(3)	not null  references pfleger
, primary key(raumnr, gebcode, pflgnr)
, foreign key(raumnr, gebcode)    references raum
);
go



--DML
begin transaction;


delete from reinigt;
delete from raum;
delete from pfleger;
delete from typ;
delete from gebaeude;
go


insert into gebaeude
  (gebcode,	gebadr)
values
  ('A',		'Amtsstraße 1')
, ('B',		'Stadtplatz 5')
;
go


insert into typ
  (sitztyp,	pflege)
values
  ('A'    ,	'Feucht abwischen')
, ('B'    ,	'Saugen')
, ('C'    ,	'Echtholzpflege')
;
go


insert into raum
  (raumnr, gebcode,	sitzanz, sitztyp)
values
  (1     , 'A'    ,	52     , 'A')
, (2     , 'A'    , 20     , 'B')
, (3     , 'A'    , 11     , 'B')
, (4     , 'A'    , 30     , 'C')
, (1     , 'B'    , 38     , 'B')
, (2     , 'B'    , 25     , 'C')
, (3     , 'B'    , 46     , 'A')
;
go


insert into pfleger
  (pflgnr, pflgrname)
values
  ('P01' , 'Maier')
, ('P02' , 'Huber')
, ('P03' , 'Bauer')
;
go


insert into reinigt
  (raumnr, gebcode, pflgnr)
values
  (1     , 'A'    , 'P01')
, (1     , 'A'    , 'P03')
, (2     , 'A'    , 'P02')
, (3     , 'A'    , 'P03')
, (4     , 'A'    , 'P02')
, (1     , 'B'    , 'P02')
, (2     , 'B'    , 'P02')
, (3     , 'B'    , 'P01')
, (3     , 'B'    , 'P03')
;
go


commit;
go


--create index;
create index idx_raum_gebcode
	on raum(gebcode)
;
go

create index idx_raum_sitztyp
	on raum(sitztyp)
;
go

create index idx_reinigt_raumnr_gebcode
	on reinigt(raumnr, gebcode)
;
go

create index idx_reinigt_pflgnr
	on reinigt(pflgnr)
;
go


--select

select gebcode, sum(sitzanz) 'stuhlanzahl'
 from raum
 group by gebcode
;


select gebcode, raumnr, pflgrname
  from reinigt r
  join pfleger p on r.pflgnr = p.pflgnr
 where r.pflgnr = 'P01'
;


select gebcode, raumnr, sitzanz
  from raum
 where sitzanz > (select avg(sitzanz)
					from raum
				 )
;