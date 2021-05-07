--Lösen Sie die Übungsaufgaben 
--4d bis 4f und 6a bis 6c zur Datenbank LTP.
--Verwenden Sie als Angabe Kapitel 8.11 aus dem Skriptum (alt).


--s20170592
--d) Nummern der Projekte, die zumindest ein Teil beinhalten, das L1 liefert.
select distinct pnr
  from ltp
  where tnr in (select tnr
				  from ltp
				 where lnr = 'L1'
			   )
;
go


--s20170592
--e) Nummern der Lieferanten, die zumindest ein Teil liefern, 
--   das zumindest von einem Lieferant geliefert wird, 
--   der zumindest ein rotes Teil liefert 
select distinct ltp.lnr
  from ltp
  join ltp ltp2 on ltp.tnr = ltp2.tnr
 where ltp.lnr != ltp2.lnr
   and exists (select farbe
				 from t
				where ltp2.tnr = t.tnr
			  )
 order by lnr
;
go


--f) Nummern der Lieferaten mit einem Rabatt kleiner 
--   als der des Lieferanten L1
select lnr
  from l
  where rabatt < (select rabatt
				    from l
				   where lnr = 'L1'
			     )
;
go



--a) 4c) mit EXISTS
--(Nummern der Teile, die an ein Projekt in London geliefert werden)
select distinct tnr
  from ltp
  where exists (select tnr
				  from p
				 where ltp.pnr = p.pnr
				   and stadt = 'London'
			   )
;
go



--b) 4d) mit EXISTS
--(Nummern der Projekte, die zumindest ein Teil beinhalten, das L1 liefert)
select distinct pnr
  from ltp
  where exists (select tnr
				  from ltp ltp1
				 where ltp1.lnr = 'L1'
				   and ltp.tnr = ltp1.tnr
			   )
;
go



--c) Nummer der Projekte, die nicht mit roten Teilen von 
--   Lieferanten aus London beliefert werden
select distinct pnr, lnr, tnr
  from ltp
 where pnr not in (select pnr
				     from ltp ltp1
				     join t on ltp1.tnr = t.tnr
				    where farbe = 'rot'
				      and lnr in (select lnr
								    from l
								   where stadt = 'London'
						 		 )
				  )
;
go
 