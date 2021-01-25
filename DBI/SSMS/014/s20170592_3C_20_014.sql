use schulungsfirma;
go


--20a
--s20170592
select count(knr) "#kursbesuche"
 from besucht
;
go

update besucht
   set bezahlt = cast('2004-01-07' as datetime)
 where knr = 4
   and knrlfnd = 1
   and pnr = 111
;
go


--20b
--s20170592
select b.knr, b.knrlfnd, b.pnr, bezahlt, von, bis
  from besucht b
  join kveranst kv on kv.knr = b.knr and kv.knrlfnd = b.knrlfnd
 where bezahlt < von
;
go

update besucht
   set bezahlt = null
 where knr = 4
   and knrlfnd = 1
   and pnr = 111
;
go

update besucht
   set bezahlt = cast('2003-04-08' as datetime)
 where knr = 1
   and knrlfnd = 1
   and pnr = 109
;
go


--20c
--s20170592
select b.knr, b.knrlfnd, b.pnr, bezahlt, von, bis
  from besucht b
  join kveranst kv on kv.knr = b.knr and kv.knrlfnd = b.knrlfnd
 where bezahlt between von and bis
;
go

update besucht
   set bezahlt = null
 where knr = 1
   and knrlfnd = 1
   and pnr = 109
;
go


--20d
--s20170592
select b.knr, b.knrlfnd, b.pnr, bezahlt, von, bis
  from besucht b
  join kveranst kv on kv.knr = b.knr and kv.knrlfnd = b.knrlfnd
 where bezahlt > bis
;
go


--20e
--s20170592
select b.knr, b.knrlfnd, b.pnr, bezahlt, von, bis
  from besucht b
  join kveranst kv on kv.knr = b.knr and kv.knrlfnd = b.knrlfnd
 where bezahlt is null
;
go

update besucht
   set bezahlt = cast('2004-01-07' as datetime)
 where knr = 4
   and knrlfnd = 1
   and pnr = 111
;
go

update besucht
   set bezahlt = cast('2003-04-08' as datetime)
 where knr = 1
   and knrlfnd = 1
   and pnr = 109
;
go


--20f
--s20170592
select b.knr, b.knrlfnd, b.pnr, bezahlt,
  case 
  when bezahlt < von
  then '<'
  when bezahlt between von and bis
  then '='
  when bezahlt > bis
  then '>'
  else '!'
  end as "status"
  , von, bis
  from besucht b
  join kveranst kv on kv.knr = b.knr and kv.knrlfnd = b.knrlfnd
;
go

update besucht
   set bezahlt = null
 where knr = 4
   and knrlfnd = 1
   and pnr = 111
;
go

update besucht
   set bezahlt = null
 where knr = 1
   and knrlfnd = 1
   and pnr = 109
;
go