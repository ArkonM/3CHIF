--Schneider Armin
--s20170592


--create database krankenkassa;
--go

use krankenkassa;
go


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
,	BKost integer		not null
);
go


create table behandelt(
	ANr integer not null references Arzt
,	PNr integer not null references Patient
,	BCode integer not null references BehArt
,	BBeginn datetime not null
);