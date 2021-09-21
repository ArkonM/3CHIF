--Schneider Armin
--s20170592


--create database krankenkassa;
--go

use krankenkassa;
go


drop table if exists behandelt;
drop table if exists BehArt;
drop table if exists Patient;
drop table if exists Arzt;


create table Arzt(
	ANr		integer		not null primary key
,	AName	varchar(42)	not null
,	AFach	varchar(42)	not null
);
go


create table Patient(
	PNr		integer		not null primary key
,	PName	varchar(42)	not null
,	PGesch	varchar(1)	not null
);
go


create table BehArt(
	BCode integer		not null primary key
,	BText varchar(58)	not null
,	BKost decimal(6, 2)	not null
);
go


create table behandelt(
	ANr     integer  not null references Arzt
,	PNr     integer  not null references Patient
,	BCode   integer  not null references BehArt
,	BBeginn datetime not null
,	primary key(ANr, PNr, BCode, BBeginn)
,	Unique (ANr, BBeginn)
);



begin transaction

delete from behandelt;
delete from BehArt;
delete from Patient;
delete from Arzt;

insert into Arzt
	(ANr, AName        , AFach                   )
values
	(52 , 'Dr. Scherer', 'Pneumologie'           )
,	(17 , 'Dr. Klocker', 'Allgemeinmedizin'      )
,	(11 , 'Dr. Postl'  , 'Ophtalmologie'         )
,	(34 , 'Dr. Pauer'  , 'Oto-Rhino-Laryngologie')
;
go


insert into Patient
	(PNr , PName  , PGesch)
values
	(3010, 'Kunz' , 'm'   )
,	(2170, 'Feigl', 'm'   )
,	(2081, 'Stern', 'w'   )
,	(2253, 'Heinz', 'w'   )
;
go


insert into BehArt
	(BCode, BText               , BKost)
values
	(407  , 'COVID-19 Nachsorge', 92   )
,	(117  , 'Grippeimpfung'     , 21   )
,	(314  , 'Staroperation'     , 295  )
,	(329  , 'Sehtest'           , 27   )
,	(398  , 'Tonsillektomie'    , 380  )
,	(125  , 'Blutabnahme'       , 18   )
;
go


insert into behandelt
	(ANr, PNr , BCode, BBeginn              )
values
	(52 , 3010, 407  , '2020-04-08 07:45:00')
,	(52 , 2170, 407  , '2020-04-07 12:03:00')
,	(52 , 2081, 407  , '2020-04-07 11:34:00')
,	(17 , 2170, 117  , '2019-10-04 18:19:00')
,	(11 , 3010, 314  , '2019-09-20 16:53:00')
,	(11 , 3010, 329  , '2018-01-15 08:00:00')
,	(34 , 2253, 398  , '2017-08-19 09:05:00')
,	(17 , 2253, 125  , '2017-08-13 14:28:00')
,	(34 , 2170, 398  , '2017-08-13 14:28:00')
,	(11 , 2081, 329  , '2016-03-12 10:44:00')

commit



select *
  from behandelt b
  join Arzt a on b.ANr = a.ANr
 where BBeginn > '2019'
;
go


select count(BCode) 'Operationen', p.PName 
  from behandelt b
  join Patient p on b.pnr = p.pnr
  group by p.PName
;
go


select AName, count(p.PNr) 'Patienten'
  from behandelt b
  join Arzt	   a on a.ANr = b.ANr
  join Patient p on p.PNr = b.PNr
  group by AName
;
go


select p.PNr, BBeginn, AName
  from behandelt b
  join Arzt    a on a.ANr = b.ANr
  join Patient p on p.PNr = b.PNr
 where BBeginn < '2020'
   and PGesch = 'm'
;
go


select PName, AName, BText, BKost, BBeginn
  from behandelt b
  join Arzt    a on a.ANr = b.ANr
  join Patient p on p.PNr = b.PNr
  join BehArt  h on h.BCode = b.BCode
 where exists (select *
				 from behandelt b2
			   having b.BBeginn = min(b2.BBeginn)
			  )
;
go


create or alter view Abrechnung
	as select a.ANr, AName, AFach, p.PNr, PName, PGesch, BBeginn, b.BCode, BText, BKost
	  from behandelt b
	  join Arzt    a on a.ANr = b.ANr
	  join Patient p on p.PNr = b.PNr
	  join BehArt  h on h.BCode = b.BCode
;
go



select *
  from Abrechnung
 order by BBeginn desc
;
go




select p.PNr, PName, PGesch, sum(BKost) 'BKost_Gesamt'
  from behandelt b 
  join BehArt h on b.BCode = h.BCode
  join Patient p on b.PNr = p.PNr
  group by p.PNr, PName, PGesch
;


select h.BCode, BText, BKost, count(BBeginn) 'BAnzahl'
  from behandelt b
  join BehArt h on b.BCode = h.BCode
 group by h.BCode, BText, BKost
 order by BAnzahl desc
;


