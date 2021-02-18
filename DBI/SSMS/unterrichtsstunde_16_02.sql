--s20170592

use lt
go


select *
  from t
 where preis > (select preis
				  from t
				 where tnr = 'T4'
			   )
;
go


select t1.*
  from t t1
  join t t2 on t2.tnr = 'T4'
 where t1.preis > t2.preis
;


select *
  from t
 where preis >= all (select preis
				       from t
			        )
;
go


select *
  from t
 where preis >= (select MAX(preis)
				  from t
			    )
;
go


select distinct lnr
  from lt
  where menge < all (select menge
		     		  from lt
				     where lnr = 'L4'
	   		        )
;