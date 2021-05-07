use ltp
go


--3a
--s20170592
select distinct stadt
  from l
 union
select distinct stadt
  from t
 union
select distinct stadt
  from p
;
go
 
 
--3b
--s20170592
select farbe
  from t
 union
select farbe
  from t
;
go


--3c
--s20170592
select farbe
  from t
 union all
select farbe
  from t
;
go


--3d
--s20170592
select distinct farbe
  from t
 union all
select distinct farbe
  from t
;
go


--8a
--s20170592
select pnr
  from ltp
except
select pnr
  from ltp
  join t on ltp.tnr = t.tnr
 where stadt = 'London'
;
go


--8b
--s20170592
select lnr
  from ltp
  join p on ltp.pnr = p.pnr
 where stadt = 'London'
intersect
select lnr
  from ltp
  join p on ltp.pnr = p.pnr
 where stadt = 'Paris'
;
go