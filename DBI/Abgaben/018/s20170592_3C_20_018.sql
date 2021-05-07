use schulungsfirma;
go

--s20170592
--4a
select knr
  from kurs k
 where exists (select knr
				 from setztvor
				where k.knr = knr
			  )
;
go



--s20170592
--4b
select distinct sv.knr, bezeichn
  from setztvor sv
  join kurs k on k.knr = sv.knr
 where exists (select sv1.knr
				 from setztvor sv1
				where k.knr = sv1.knr
			  )
;
go


--s20170592
--4c
select distinct sv.knr, bezeichn
  from setztvor sv
  join kurs k on k.knr = sv.knr
 where exists (select sv1.knr
				 from setztvor sv1
				where k.knr = sv1.knr
			  )
;
go