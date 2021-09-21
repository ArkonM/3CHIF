--create database happysushi;
--go

use happysushi;
go

set nocount on;
go

--DDL


drop table if exists leitet;
drop table if exists arbeitet;
drop table if exists untersteht;
drop table if exists Angestellter;
drop table if exists Filiale;
go

--4)

create table Filiale (
  FNr     integer     not null primary key
, Straße  varchar(30) not null 
, Ort     varchar(15) not null
, PLZ     varchar(4)  not null
, Telefon varchar(14) not null 
);
go

create table Angestellter (
  SVN      varchar(10)   not null primary key
, Vorname  varchar(10)   not null
, Nachname varchar(15)   not null 
, Telefon  varchar(12)   not null 
, Gehalt   decimal(8, 2) not null
);													    
go	
										    
create table untersteht (							    
  SVN    varchar(10) not null						    
, SVNvor varchar(10) not null						    
, primary key (SVN, SVNvor)							    
);													    
go													    
													    
create table arbeitet ( 							    
  SVN      varchar(10) not null references Angestellter --5)
, FNr      integer     not null references Filiale      --5)
, primary key (SVN, FNr)
);
go

--5)
create table leitet (
  SVN varchar(10) not null references Angestellter unique --8)
, FNr integer     not null references Filiale unique --8)
, primary key (SVN, FNr)
);
go


--DML 

--6)

begin transaction;
go

delete from leitet;
delete from arbeitet;
delete from untersteht; 
delete from Angestellter;
delete from Filiale;
go


insert into Filiale 
  (FNr, Straße,                        Ort,          PLZ,             Telefon)
values											        
  (  1, 'Burggasse 71',                'Wien',         '1070', '01 / 522 91 03')
, (  2, 'Prokopigasse 4',              'Graz',         '8010', '0316 / 852 285')
, (  3, 'Matthias Corvinus-Strasse 15', 'St. Poelten', '3100', '02742 / 51 510')
;
go

insert into Angestellter 
  (SVN,          Vorname,      Nachname,    Telefon,         Gehalt)
values 
  ('2072980526', 'Carina',     'Aschauer',  '0664 / 12072', 2072.00)
, ('2075980809', 'Hans-Peter', 'Enser',     '0664 / 12075', 2075.00)
, ('2076970925', 'Michael',    'Ernst',     '0664 / 12076', 2076.00)
, ('2079980221', 'Marcel',     'Fortin',    '0664 / 12079', 2079.00)
, ('1073970812', 'Michael',    'Frankolin', '0664 / 11073', 1073.00)
;
go

insert into leitet 
  (SVN,        FNr)
values 
  ('2072980526', 1)
, ('2076970925', 2)
, ('2079980221', 3)
;
go

insert into arbeitet 
  (SVN,        FNr)
values 
  ('2072980526', 1)
, ('2076970925', 2)
, ('2079980221', 3)
;
go

commit;
go


--7)

begin transaction;



go 

commit


begin transaction

--8)

/*insert into Filiale
	(FNr, Straße,                        Ort,          PLZ,             Telefon)
values
	(4, 'Altstadt 10', 'Linz', '4020', '0732 / 786 611')
;

insert into leitet 
  (SVN,        FNr)
values 
  ('2072980526', 4)
;
go*/


select *
  from leitet
;

rollback


--9)

select Nachname, Vorname, Ort 'Filiale', A.Telefon 'TelPrivat', F.Telefon 'TelFiliale'
  from leitet l
  join Angestellter A on A.SVN = l.SVN
  join Filiale F on F.FNr = l.FNr
 order by Nachname, Vorname
;

--10)

select Straße, Ort, PLZ, F.Telefon, Vorname, Nachname
  from leitet l
  join Angestellter A on A.SVN = l.SVN
  join Filiale F on F.FNr = l.FNr
 order by PLZ
;


