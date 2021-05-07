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