--Schneider Armin
--s20170592

use lt;
go


--Verhatlen von NULL in einem Ausdruck
--s20170592
select preis+NULL   --Addiere NULL zu INT; Nicht möglich da NULL nicht
  from t			--vorhanden -> Ergebnis nicht vorhanden
;
go



use lt0;
go


--Verhalten von NULL in der WHERE-Klausel
--s20170592
select preis
  from t
 where preis < 15   --Mit NULL vergleichen funktioniert nicht
;					--daher kein Ergebnis bei dem Datensatz mit NULL
go


--Verhalten im CHECK constraint
--s20170592
begin transaction

ALTER TABLE t
ADD CHECK(NULL > 0)   --Beim Checken ob NULL größer 0 ist wird
					  --TRUE ausgegeben
select *
  from t
;
go

rollback



--Stolperfalle = NULL bzw. != NULL in WHERE-Klausel
--s20170592
select farbe
  from t
 where farbe = NULL   --Mit NULL vergleichen funktioniert nicht
;					  --daher kein Ergebnis
go

--s20170592
select farbe
  from t
 where farbe != NULL   --Wie oben vergleiche ich auch hier mit NULL
;
go




--Verhalten von NULL in ORDER BY-Klausel
--s20170592
select farbe
  from t
 order by farbe     --NULL wir bei asc oben angeschrieben
;					--bei desc wir NULL unten angeschrieben
go


--Prüfen auf NULL mit IS NULL bzw. IS NOT NULL.
--s20170592
select *
  from t
 where farbe is not NULL    --Funktionierende Testung nach NULL
;							--is (not) NULL liefert ein richtiges Ergebnis
go



--Verhalten bei Aggregatfunktionen
--s20170592
select COUNT(preis) "count"
	 , AVG(preis) "avg"			--Aggregatfunktionen löschen alle
	 , MIN(preis) "min"			--Datensätze in denen sich NULL befindet
	 , MAX(preis) "max"
  from t
;
go


use lt;
go

select COUNT(preis) "count"
	 , AVG(preis) "avg"			--Wenn nur NULL zu verfügung steht
	 , MIN(preis) "min"			--liefern alle Funktionen mit Ausnahem
	 , MAX(preis) "max"			--von COUNT, NULL zurück. COUNT liefert 0
  from t
;
go



use lt0;
go


--Entstehung von NULL durch OUTER JOIN
--s20170592
select *
  from t
  left outer join t t1 on t.farbe = t1.farbe
;					--NULL entsteht, da wenn die join voraussetzung nicht erfüllt wird
go					--wird zum linken Datensatz im Rechten NULL eingefügt