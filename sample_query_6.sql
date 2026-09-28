SELECT
    f.title      AS film_title,
    c.name       AS cinema_name,
    c.district   AS district,
    h.name       AS hall_name,
    s.start_time AS session_time
FROM film f
JOIN session s ON s.film_id = f.film_id
JOIN hall   h  ON s.hall_id = h.hall_id
JOIN cinema c  ON h.cinema_id = c.cinema_id
WHERE f.has_awards = TRUE
ORDER BY f.title, s.start_time;