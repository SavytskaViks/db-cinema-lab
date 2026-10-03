SELECT
    f.title      AS film_title,
    c.name       AS cinema_name,
    c.district   AS district,
    h.name       AS hall_name,
    s.start_time AS session_time
FROM film f
JOIN repertoire r ON r.film_id       = f.film_id
JOIN session    s ON s.repertoire_id = r.repertoire_id
JOIN hall       h ON h.hall_id       = s.hall_id
JOIN cinema     c ON c.cinema_id     = r.cinema_id
WHERE f.has_awards = TRUE
ORDER BY f.title, s.start_time;