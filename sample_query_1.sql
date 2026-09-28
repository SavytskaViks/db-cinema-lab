SELECT
    h.name          AS hall_name,
    f.title         AS film_title,
    s.start_time    AS session_time,
    s.base_price    AS ticket_price
FROM session s
JOIN hall   h ON s.hall_id = h.hall_id
JOIN cinema c ON h.cinema_id = c.cinema_id
JOIN film   f ON s.film_id  = f.film_id
WHERE c.name ILIKE 'Multiplex' AND c.district ILIKE 'Франківський'
ORDER BY s.start_time;
