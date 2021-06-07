-- Abfrage 1
-- Gesamter Reinigungsplan wie in der Tabelle der Aufgabenstellung
-- Sortierung nach GebCode, RaumNr, PflgrNr

select *
  from Pfleger
;
select *
  from gebaeude
;
select *
  from Typ
;
select *
  from Raum
;


select geb.Gebcode, GebAdr, RaumNr, SitzAnz, r.SitzTyp, Pflege--, PflgNr, PflgrName
  from gebaeude geb
  join Raum r on r.GebCode = geb.GebCode
  join Typ t on t.SitzTyp = r.SitzTyp
  join Pfleger pf on pf.SitzTyp = r.SitzTyp
;


GebCode GebAdr           RaumNr      SitzAnz     SitzTyp Pflege           PflgrNr PflgrName       
------- ---------------- ----------- ----------- ------- ---------------- ------- ----------------
A       Amtsstraﬂe 1               1          52 A       Feucht abwischen P01     Maier           
A       Amtsstraﬂe 1               1          52 A       Feucht abwischen P03     Bauer           
A       Amtsstraﬂe 1               2          20 B       Saugen           P02     Huber           
A       Amtsstraﬂe 1               3          11 B       Saugen           P03     Bauer           
A       Amtsstraﬂe 1               4          30 C       Echtholzpflege   P02     Huber           
B       Stadtplatz 5               1          38 B       Saugen           P02     Huber           
B       Stadtplatz 5               2          25 C       Echtholzpflege   P02     Huber           
B       Stadtplatz 5               3          46 A       Feucht abwischen P01     Maier           
B       Stadtplatz 5               3          46 A       Feucht abwischen P03     Bauer           

-- Abfrage 2
-- Wieviel Sitze hat ein Raum durchschnittlich?

Schnitt SitzAnz
---------------
             31

-- Abfrage 3
-- Wieviele Sitze gibt es von jedem Typ?
-- Sortierung nach SitzTyp
 
SitzTyp Pflege           Anzahl     
------- ---------------- -----------
A       Feucht abwischen          98
B       Saugen                    69
C       Echtholzpflege            55

-- Abfrage 4
-- Wieviele R‰ume reinigt jeder Pfleger?
-- Sortierung nach Anzahl absteigend

 
PflgrNr PflgrName        Anzahl     
------- ---------------- -----------
P02     Huber                      4
P03     Bauer                      3
P01     Maier                      2

-- Abfrage 5
-- Wieviele Sitzpl‰tze hat jedes der Geb‰ude?
-- Sortierung nach GebCode
 
GebCode Gesamt-SitzAnz
------- --------------
A                  113
B                  109