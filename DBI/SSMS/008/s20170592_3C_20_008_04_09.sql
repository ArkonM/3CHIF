--s20170592
--schneider.armin@student.htlwrn.ac.at
use schulungsfirma;
go

--Aufgabe 4a
--s20170592
--schneider.armin@student.htlwrn.ac.at

select distinct knr
  from setztvor
;
go

--Aufgabe 4b

select distinct kurs.knr, bezeichn
  from kurs
  join setztvor on setztvor.knr = kurs.knr
;
go

--Aufgabe 4c

select distinct kurs.knr, bezeichn
  from kurs, setztvor
 where setztvor.knr = kurs.knr
;
go

--Aufgabe 5
--s20170592
--schneider.armin@student.htlwrn.ac.at

select distinct bezeichn
  from kurs
 where tage between 2 and 4
   and preis/tage <= 700
;
go

--Aufgabe 6
--s20170592
--schneider.armin@student.htlwrn.ac.at

select distinct fname, vname, ort
  from person
 where vname like '% %'
   and ort like '%a%a%'
    or ort like '%e%e%'
	or ort like '%i%i%'
	or ort like '%o%o%'
	or ort like '%u%u%'
;
go

--Aufgabe 7
--s20170592
--schneider.armin@student.htlwrn.ac.at

select distinct pnr
  from besucht
 where bezahlt is null
;
go

--Aufgabe 8
--s20170592
--schneider.armin@student.htlwrn.ac.at

select knr, knrlfnd, (datediff(d, von, bis)+1) as tage
  from kveranst
 where ort = 'Wien'
   and pnr in (103 , 104)
 order by knr desc
;
go

--Aufgabe 9
--s20170592
--schneider.armin@student.htlwrn.ac.at

select pnr, datediff(yy, gebdat, getdate()) as "alter"
  from referent
;
go