--use lt;
--go

--lnr, lname und die anzahl der teile die ein lieferant liefert
select l.lnr, l.lname
	 , count(tnr) "anzahl"
  from l
  join lt on l.lnr = lt.lnr
 group by l.lnr, lname
union
select l.lnr, lname, 0 "anzahl"
  from l
 where lnr not in (select lnr
					 from lt
				   )
;
go


select l.lnr, lname
  from l
  left join lt on l.lnr = lt.lnr
 where menge is null
;
go


select lname, coalesce(lt.menge*t.preis, 0) "umsatz"
  from l
  left join lt on l.lnr = lt.lnr
  left join t on lt.tnr = t.tnr
  order by umsatz desc
;
go