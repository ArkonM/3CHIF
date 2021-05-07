--Schneider Armin
--s20170592

use ltp;
go


--6d  Nummern der Projekte, die ausschlieﬂlich von Lieferant L2 beliefert werden
--s20170592
select pnr
  from ltp
 where lnr = 'L2'
   and not exists (select pnr
					from ltp ltp1
				   where lnr != 'L2'
					 and ltp.pnr = ltp1.pnr
				  )
;
go


--6e  Nummern der Teile, die an alle Projekte in London geliefert werden 
--s20170592
select distinct ltp1.tnr
  from ltp ltp1
  join ltp ltp2 on ltp1.tnr = ltp2.tnr
			   and ltp1.pnr != ltp2.pnr
 where ltp1.pnr in (select pnr
					  from p
					 where stadt = 'London'
				   )
   and ltp2.pnr in (select pnr
				      from p
				     where stadt = 'London'
				   )
;
go


--6f Nummern der Projekte, die zumindest mit allen Teilen beliefert werden, die Lieferant L1 liefert
--s20170592





begin transaction

delete ltp;

insert into ltp
  (lnr,  tnr , pnr , menge)
values
  ('L1', 'T2', 'P2',   200)
, ('L1', 'T3', 'P3',   200)
, ('L1', 'T4', 'P4',   200)
, ('L1', 'T5', 'P5',   200)
, ('L1', 'T6', 'P6',   200)
;








rollback