--use ltp
--go

--s20170592
--5g
select tnr
  from ltp
  join l on l.lnr = ltp.lnr
  join p on p.pnr = ltp.pnr
 where p.stadt = l.stadt
;
go


--s20170592
--5h
select distinct ltp.pnr
  from ltp
  join l on l.lnr = ltp.lnr
  join p on p.pnr = ltp.pnr
 where p.stadt <> l.stadt
;
go


--s20170592
--5i
select distinct ltp1.tnr, ltp2.tnr
  from ltp ltp1
  join ltp ltp2 on ltp1.lnr = ltp2.lnr
  join l on ltp1.lnr = l.lnr
 where ltp1.tnr < ltp2.tnr
;
go


--use schulungsfirma
--go


--s20170592
--19
select bezeichn, von, bis, LEFT(preis/tage, 6) tagespreis
  from kurs k
  join kveranst kv on k.knr = kv.knr
 where (preis/tage) > 610 and (preis/tage) < 690
;
go


--s20170592
--21
select distinct fname
  from person p
  join besucht b on p.pnr = b.pnr
  join kveranst kv on b.knr = kv.knr and b.knrlfnd = kv.knrlfnd
									 and p.ort = kv.ort
  join kurs k on kv.knr = k.knr
   and k.tage > 2
;
go


--s20170592
--22
select bezeichn, knrlfnd
 from geeignet g
 join kveranst kv on g.pnr = kv.pnr and g.knr = kv.knr
 join kurs k on kv.knr = k.knr
;
go