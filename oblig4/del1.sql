/* obligatorisk innlevering 4 i in2090
del 1 - Avansert SQL */

-- oppgave 1
SELECT filmcharacter, COUNT(filmcharacter)
FROM filmcharacter
GROUP BY filmcharacter
  HAVING COUNT(filmcharacter) > 2000
  ORDER BY COUNT(filmcharacter) DESC;
-- returnerer 90 rader

-- oppgave 2
SELECT DISTINCT country
FROM filmcountry
GROUP BY country
  HAVING COUNT(country) = 1;
-- returnerer 9 rader

-- oppgave 3
SELECT f.title, fp.parttype, COUNT(fp.parttype) AS parts
FROM filmparticipation fp
  NATURAL JOIN filmitem fi
  NATURAL JOIN film f
WHERE f.title
LIKE '%Lord of the Rings%'
AND fi.filmtype = 'C'
GROUP BY (f.title, fp.parttype);
-- 27 rader

-- oppgave 4
SELECT f.title, f.prodyear
FROM film f, filmgenre fgn, filmgenre fgc
WHERE f.filmid = fgn.filmid
  AND fgn.filmid = fgc.filmid
  AND fgn.genre = 'Film-Noir'
  AND fgc.genre = 'Comedy';
--returnerer 3 rader

-- oppgave 5
SELECT f.votes, s.maintitle
FROM filmrating f
INNER JOIN series s ON(f.filmid = s.seriesid)
WHERE f.votes > 1000
  AND f.rank =
  (SELECT MAX (f.rank)
   FROM filmrating f
   WHERE f.votes > 1000)
GROUP BY(s.maintitle, f.votes);
-- returnerer 3 rader

-- oppgave 6

-- må legge til en LEFT JOIN for å få alle 20 filmene
SELECT f.title, COUNT(fl.language)
FROM film f, filmlanguage fl
NATURAL JOIN filmcharacter fc
NATURAL JOIN filmparticipation fp
WHERE fc.partid = fp.partid
AND fp.filmid = f.filmid
AND fc.filmcharacter
LIKE 'Mr. Bean'
GROUP BY f.title
  ORDER BY COUNT(fl.language) DESC;
-- 16 rader

-- finner alle filmene, gir 20 rader, men ikke språk
SELECT f.title
FROM film f
NATURAL JOIN filmcharacter fc
NATURAL JOIN filmparticipation fp
WHERE fc.partid = fp.partid
AND fp.filmid = f.filmid
AND fc.filmcharacter
LIKE 'Mr. Bean'
GROUP BY f.title

-- 20 rader, bare filmer



-- oppgave 7
WITH unikeRoller AS
(SELECT *
FROM (SELECT filmcharacter, COUNT(*)
    FROM filmcharacter
    GROUP BY filmcharacter
    HAVING COUNT(*) = 1)
  AS uchar, filmcharacter AS fchar
  WHERE uchar.filmcharacter = fchar.filmcharacter)
SELECT firstname || ' ' || lastname AS name, COUNT(*) AS movies
FROM person
NATURAL JOIN filmparticipation
NATURAL JOIN unikeRoller
GROUP BY name
  HAVING COUNT(*) > 199
  ORDER BY movies;
-- returnerer 13 rader
