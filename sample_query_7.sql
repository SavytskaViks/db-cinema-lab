SELECT
    f.title      AS film_title,
    c.name       AS cinema_name,
    c.district   AS district,
    s.start_time AS session_time
FROM session s
JOIN repertoire  r  ON r.repertoire_id = s.repertoire_id
JOIN film        f  ON f.film_id       = r.film_id
JOIN film_genre  fg ON fg.film_id      = f.film_id
JOIN genre       g  ON g.genre_id      = fg.genre_id
JOIN cinema      c  ON c.cinema_id     = r.cinema_id
WHERE g.name ILIKE 'Комедія'
  AND s.start_time IN ('2026-09-25 16:00:00', '2026-09-27 15:00:00', '2026-09-27 22:00:00')
ORDER BY s.start_time;