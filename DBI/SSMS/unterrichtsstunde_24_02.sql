--use lt;
--go

--s20170592
select tnr
  from lt 
 where lnr = 'L2'
;

select distinct lnr
  from lt
 where tnr in (select tnr
				 from lt 
				where lnr = 'L2'
			  )
   and lnr != 'L2'
;
go



select *
  from lt
 where lnr in (select lnr
				 from lt
				where tnr = 'T1'
			  )
   and lnr in (select lnr
				 from lt
				where tnr = 'T2'
			  )
;
go



select distinct lt1.lnr, lname
  from lt lt1
  join l on l.lnr = lt1.lnr
  join lt lt2 on lt1.lnr = lt2.lnr
 where lt1.tnr = 'T1'
   and lt2.tnr = 'T2'
;
go


select lnr, lname
  from l
 where lnr not in (select lnr
					 from lt
				  )
;
go


--EXISTS
--Korrelierte Abfrage, verwendet Werte aus der ‰uﬂeren Abfrage

select lnr, lname
  from l
 where not exists (select lnr
					 from lt
					where lnr = l.lnr
				  )
;
go