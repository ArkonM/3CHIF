--use schulungsfirma;
--go

--Example CAST

select cast('23' as int)
;
go


--Example CONVERT

select convert(int, '23')
;
go

--Example DATEPART

select datepart(day, '2020/01/11')
;
go

--Example CHAR

select char(70)
;
go

--Example ASCII

select ascii('F')
;
go

--Example UPPER

select upper('Hallo')
;
go

--Example LOWER

select lower('Wiederschaun')
;
go

--Example LEN

select len('123456789')
;
go

--Example SPACE

select ('Hallo' + SPACE(2) + 'Test')
;
go

--Example ROUND

select round(11.7, 0, 0)
;
go

--Example TRANSLATE

select translate('Hallo, wie gehts', 'l,ih','1234')
;
go

--Example REPLACE

select replace('Hallo, wie gehts', 'lo','12')
;
go

--Example GETDATE

select getdate()
,      year(getdate())
,      month(getdate())
,      day(getdate())
;
go

--Example DATEADD

select dateadd(year, 2, '2018/02/10')
;
go

--Example SUM

select sum(preis)
  from kurs
;
go

--Example COUNT

select count(1)
  from kveranst
 where knr = 1
;
go

--Example AVG

select avg(knr)
  from kveranst
;
go

--Example MIN

select min(knr)
  from kveranst
;
go

--Example MAX

select max(knr)
  from kveranst
;
go

--Example LEFT

select left('Hallo', 3)
;
go

--Example RIGHT

select right('Hallo', 2)
;
go

--Example STUFF

select stuff('Hallo', 1, 2, '  ')
;
go

--Example COALESCE

select coalesce(null, 'Test', null, 'Test2')
;
go

--Example DATEDIFF

select datediff(yy, bis, getdate())
  from kveranst
;
go

--Example IIF

select iif(preis < 1700, 'billig', 'Teuer')
  from kurs
;
go

--Example PATINDEX

select patindex('%kunde', bezeichn)
  from kurs
;
go

--Example SQRT

select sqrt(preis)
  from kurs
;
go

--Example POWER

select power(preis, 1.4)
  from kurs
;
go

--Example REVERSE

select reverse('This is a test')
;
go

--Example STRING_SPLIT

select value
  from string_split('This is a test', ' ')
;
go


--schneider.armin@student.htlwrn.ac.at