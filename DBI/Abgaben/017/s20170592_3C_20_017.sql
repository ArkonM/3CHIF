use schulungsfirma;
go

--s20170592
select p.pnr, p.fname
  from person p
  where p.pnr in (select b.pnr
				    from besucht b
				    join kveranst k on k.knr = b.knr
					     		   and k.knrlfnd = b.knrlfnd
			       where k.ort = 'Wien'
			         and b.pnr = p.pnr
			     )
union
select p.pnr, p.fname
  from person p 
  where p.pnr in (select pnr
				    from kveranst
				   where ort = 'Wien'
				     and pnr = p.pnr
				 )
 order by p.pnr
;
go


--20170592
--set language German;
--set DATEFIRST 2;
select k.knr, k.bezeichn, k.tage, kv.knrlfnd,
       kv.von, DATENAME(dw, DATEPART(dw, kv.von)) von_wotag, kv.bis, 
	   DATENAME(dw, DATEPART(dw, kv.bis)) bis_wotag, DATEDIFF(dw, kv.von, kv.bis)+1 von_bis_tage
  from kurs k
  join kveranst kv on k.knr = kv.knr
  where DATEPART(dw, kv.von) < DATEPART(dw, kv.bis)
    and DATEPART(dw, kv.bis) >= 5
	 or DATEPART(dw, kv.von) > DATEPART(dw, kv.bis)
	and DATEPART(dw, kv.von) < 7
;
go


--20170592
select distinct p.pnr, p.fname, p.vname
  from kveranst kv
  join person p on p.pnr = kv.pnr
  join referent ref on kv.pnr = ref.pnr
 where DATEDIFF(yy, ref.gebdat, kv.bis) >= 60
 order by p.pnr
;
go