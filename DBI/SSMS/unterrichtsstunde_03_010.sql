use lt;
go

select farbe
	 , COUNT(tnr) "anzahl_teile"
	 , MIN(preis) "min_preis"
     , MAX(preis) "max_preis"
	 , AVG(preis) "avg_preis"
  from t
 group by farbe
;
go


select COUNT(distinct farbe) "versch_farben"
  from t
;
go


select COUNT(lnr) "anz", stadt
  from l
 group by stadt
having COUNT(lnr) > 1
 order by anz desc
;
go