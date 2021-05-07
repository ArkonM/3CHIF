use ltp;
go

--s20170592
--5a
select ltp.lnr, ltp.tnr, ltp.pnr
  from ltp
  join l on l.lnr = ltp.lnr
  join t on t.tnr = ltp.tnr
  join p on p.pnr = ltp.pnr
 where t.stadt = l.stadt
   and p.stadt = l.stadt
   and p.stadt = t.stadt
;
go


--s20170592
--5b
select ltp.lnr, ltp.tnr, ltp.pnr
  from ltp
  join l on l.lnr = ltp.lnr
  join t on t.tnr = ltp.tnr
  join p on p.pnr = ltp.pnr
 where t.stadt <> l.stadt
    or p.stadt <> l.stadt
    or p.stadt <> t.stadt
;
go


--s20170592
--5c
select ltp.lnr, ltp.tnr, ltp.pnr
  from ltp
  join l on l.lnr = ltp.lnr
  join t on t.tnr = ltp.tnr
  join p on p.pnr = ltp.pnr
 where t.stadt <> l.stadt
   and p.stadt <> l.stadt
   and p.stadt <> t.stadt
;
go


--s20170592
--5d
select distinct t.tnr
  from ltp
  join l on l.lnr = ltp.lnr
  join t on t.tnr = ltp.tnr
 where l.stadt = 'London'
;
go


--s20170592
--5e
select distinct t.tnr
  from ltp
  join l on l.lnr = ltp.lnr
  join t on t.tnr = ltp.tnr
  join p on p.pnr = ltp.pnr
 where l.stadt = 'London'
   and p.stadt = 'London'
;
go


--s20170592
--5f
select distinct l.stadt 'l_stadt', p.stadt 'p_stadt'
  from ltp
  join l on l.lnr = ltp.lnr
  join p on p.pnr = ltp.pnr
 where l.stadt = p.stadt
;
go

