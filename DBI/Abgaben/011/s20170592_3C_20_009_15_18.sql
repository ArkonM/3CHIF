--schneider.armin@student.htlwrn.ac.at
use schulungsfirma

--15a
select distinct ku.bezeichn, k.von, fname, vname
  from kurs ku
  join kveranst k on ku.knr = k.knr
  join besucht b on b.knr = ku.knr
  join person p on p.pnr = b.pnr
 group by von, bezeichn, fname, vname
;
go


--schneider.armin@student.htlwrn.ac.at
--15b
select distinct ku.bezeichn, k.von, p.fname as tn_fname, p.vname as tv_vname, pe.fname as ref_fname, pe.vname as ref_vname
  from kurs ku
  join kveranst k on ku.knr = k.knr
  join besucht b on b.knr = ku.knr and b.knrlfnd = k.knrlfnd
  join person p on p.pnr = b.pnr
  join person pe on pe.pnr = k.pnr
 order by von, bezeichn, p.fname, p.vname
;
go


--schneider.armin@student.htlwrn.ac.at
--16
select distinct bezeichn, k.von
  from kurs ku
  join kveranst k on k.knr = ku.knr
  join besucht b on b.pnr = k.pnr
  join referent ref on  b.pnr = ref.pnr
 order by bezeichn
;


--schneider.armin@student.htlwrn.ac.at
--17
select distinct ku.bezeichn, k.von
  from kurs ku
  join kveranst k on k.knr = ku.knr
  join besucht b on b.knr = k.knr
				and b.knrlfnd = k.knrlfnd
 where b.pnr = k.pnr
 order by bezeichn
;


--schneider.armin@student.htlwrn.ac.at
--18a
select p.fname
  from besucht b, besucht b2, person p, person p2
 where b.pnr = p.pnr
   and b2.pnr = p2.pnr
   and p.pnr = p2.pnr
   and b.knr = 1
   and b2.knr = 5
;
go


--schneider.armin@student.htlwrn.ac.at
--18b
select p.fname
  from besucht b
  join person p on b.pnr = p.pnr
 cross join besucht b2
  join person p2 on p2.pnr = b2.pnr
   and p.pnr = p2.pnr
 where b.knr = 1 and b2.knr = 5
;
go