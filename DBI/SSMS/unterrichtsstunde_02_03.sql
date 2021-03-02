use lt;
go

select lnr
  from lt
;

select lnr, lname
  from l
 where exists (select lnr
				 from lt
				where lt.lnr = l.lnr
			  )
;
go



select lnr, lname
  from l
 where lnr in (select lnr
			     from lt
			  )
;
go


--Welche Lieferanten (lnr) haben keine Roten Teile geliefert
select lnr, lname
  from l
 where lnr not in (select lnr
					 from lt
				    where tnr in (select tnr
								    from t
								   where farbe = 'rot'
							     )
			      )
;
go



select lnr, lname
  from l
 where not exists (select *
					 from lt
					 join t on lt.tnr = t.tnr
				    where t.farbe = 'rot'
				      and l.lnr = lt.lnr
				  )
;
go