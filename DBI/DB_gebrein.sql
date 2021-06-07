-- DDL-Kommandos

-- create database gebrein;
-- go

use gebrein;
go

drop table if exists reinigt;
drop table if exists Raum;
drop table if exists Pfleger;
drop table if exists Typ;
drop table if exists Gebaeude;
go

create table Gebaeude (
  GebCode varchar(4)  not null primary key
, GebAdr  varchar(16) not null
);
go

create table Typ (
  SitzTyp varchar(2)  not null primary key
, Pflege  varchar(16) not null
);
go

create table Pfleger (
  PflgrNr   varchar(4)  not null primary key
, PflgrName varchar(16) not null
);
go

create table Raum (
  GebCode varchar(4) not null references Gebaeude
, RaumNr  integer    not null 
, SitzAnz integer    not null check(SitzAnz >= 0)
, SitzTyp varchar(2) not null references Typ
, primary key (GebCode, RaumNr)
);
go

create table reinigt (
  GebCode varchar(4) not null
, RaumNr  integer    not null 
, PflgrNr varchar(4) not null references Pfleger
, foreign key (GebCode, RaumNr) references Raum
, primary key (GebCode, RaumNr, PflgrNr)
);
go

-- Fremdschlüssel indizieren

-- GebCode in Raum muss nicht indiziert werden, da es im PK am Anfang steht.

create index idx_Raum_SitzTyp 
    on Raum(SitzTyp);
go

-- GebCode mit RaumNr in reinigt muss nicht indiziert werden, da es im PK
-- am Anfang steht.

create index idx_reinigt_PflgrNr 
    on reinigt(PflgrNr);
go

-- DML-Kommandos

set nocount on

begin transaction;

delete from reinigt;
delete from Raum;
delete from Pfleger;
delete from Typ;
delete from Gebaeude;
go

insert into Gebaeude
  (GebCode, GebAdr        )
values
  ('A'    , 'Amtsstraße 1')
, ('B'    , 'Stadtplatz 5')
;
go

insert into Typ
  (SitzTyp, Pflege)
values
  ('A'    , 'Feucht abwischen')
, ('B'    , 'Saugen'          )
, ('C'    , 'Echtholzpflege'  )
;
go

insert into Pfleger
  (PflgrNr, PflgrName)
values
  ('P01'  , 'Maier'  )
, ('P02'  , 'Huber'  )
, ('P03'  , 'Bauer'  )
;
go

insert into Raum
  (GebCode, RaumNr, SitzAnz, SitzTyp)
values
  ('A'    ,      1,      52, 'A'    )
, ('A'    ,      2,      20, 'B'    )
, ('A'    ,      3,      11, 'B'    )
, ('A'    ,      4,      30, 'C'    )
, ('B'    ,      1,      38, 'B'    )
, ('B'    ,      2,      25, 'C'    )
, ('B'    ,      3,      46, 'A'    )
;
go

insert into reinigt
  (GebCode, RaumNr, PflgrNr)
values
  ('A'    ,      1, 'P01'  )
, ('A'    ,      1, 'P03'  )
, ('A'    ,      2, 'P02'  )
, ('A'    ,      3, 'P03'  )
, ('A'    ,      4, 'P02'  )
, ('B'    ,      1, 'P02'  )
, ('B'    ,      2, 'P02'  )
, ('B'    ,      3, 'P01'  )
, ('B'    ,      3, 'P03'  )
;
go

commit;
go