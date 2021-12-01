-- obligatorsik innlevering 2 i IN2090
-- Emma Daae

-- OPPGAVE 2
-- a)
SELECT *
FROM timelistelinje t
WHERE t.timelistenr = 3;

-- b)
SELECT COUNT(*)
AS AntallTimelister
FROM timeliste;

-- c)
SELECT COUNT(*)
FROM timeliste t
-- setter utbetalt-verdi til null for å finne timelister som ikke
-- er utbetalt
WHERE t.utbetalt is NULL;

-- d)
SELECT COUNT(*)
AS AntallTimelistelinjer,
COUNT(pause)
AS AntallMedPause
FROM timelistelinje;

-- e)
SELECT COUNT(*)
FROM timelistelinje t
-- setter pause-verdi til null for å finne timelister som ikke
-- har pauseverdi
WHERE t.pause is NULL;

-- OPPGAVE 3

-- a)
-- bruker SUM() på varighet for å summere varighet verdier
-- og deler på 60 for å få timer i stedet for minutter
SELECT SUM(varighet)/60
AS IkkeUtbetalt
FROM timeliste t
-- bruker inner join for å slå sammen tabellene
INNER JOIN varighet
ON t.timelistenr = varighet.timelistenr
-- setter levert-verdi til å ikke være null for å kun få de som er levert
-- og utbetalt til null for å kun få de som ikke er utbetalte
WHERE t.levert is NOT NULL AND t.utbeltalt is NULL;

-- b)
-- bruker SELECT DISTINCT for å unngå duplikater
SELECT DISTINCT t.timelistenr, t.beskrivelse
FROM timeliste t
INNER JOIN timelistelinje tl
ON t.timelistenr = tl.timelistenr
WHERE tl.beskrivelse LIKE '%test%'
or tl.beskrivelse LIKE '%Test%';

-- c)
-- bruker samme fremgangsmåte som i a) for å finne antall timer, og
-- ganger med 200 for å finne sum utbetalt dersom lønn er 200kr timen
SELECT SUM(varighet)/60*200
AS utbetalt
FROM timeliste t
INNER JOIN varighet
ON t.timelistenr = varighet.timelistenr
WHERE t.levert is NOT NULL AND t.utbetalt IS NULL;

-- OPPGAVE 4

-- a)
-- De to spørringene gir ikke likt svar fordi når vi bruker NATURAL JOIN så
-- slår vi sammen tabellene der timelistenummeret er like, mens når vi
-- bruker INNER JOIN så slår sammen de kollonene der navn og beskrivelse
-- på timelistelinjene er identisk.

--b)
-- De to spørringene gir likt svar fordi den første spørringen med NATURAL JOIN
-- resulterer i at vi legger sammen kolonnone med samme navn.
-- Mens vi i den andre spørringen ved bruke av INNER JOIN slår sammen
-- timelistetabellen og view på varighet i timelistenummeret.
