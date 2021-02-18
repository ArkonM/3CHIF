use schulungsfirma
go

--s20170592
--23
select distinct r.pnr, p.fname, p.vname
  from referent r
  join person p on r.pnr = p.pnr
  join kveranst kv on r.pnr = kv.pnr
  where r.seit < kv.bis
  order by r.pnr
;
go


--s20170592
--40a
select k.bezeichn
  from kveranst kv1
  join kveranst kv2 on kv1.knr = kv2.knr
  join kurs k on k.knr = kv1.knr
  where kv1.ort = 'Wien' and kv2.ort = 'Paris'
;
go


--40b
select distinct k.bezeichn
  from kveranst kv1
  join kurs k on k.knr = kv1.knr
  join kveranst kv2 on kv1.knr = kv2.knr
  where kv1.knr not in (select knr
						  from kveranst
						 where ort = 'Paris'
					   )
;
go


--s20170592
--43
select k.bezeichn, kv.von, kv.bis, k.preis, k.preis+k.preis/10*((DATEPART(dw , kv.von) + 
																 DATEDIFF(dw, kv.von, kv.bis))) we_preis
  from kurs k
  join kveranst kv on k.knr = kv.knr
;