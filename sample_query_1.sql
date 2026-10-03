SELECT
    h.name          AS hall_name,
    f.title         AS film_title,
    s.start_time    AS session_time,
    sp.ticket_price AS ticket_price
FROM session s
JOIN session_price sp ON sp.session_id    = s.session_id
JOIN repertoire    r  ON r.repertoire_id  = s.repertoire_id
JOIN hall          h  ON h.hall_id        = s.hall_id
JOIN cinema        c  ON c.cinema_id      = r.cinema_id
JOIN film          f  ON f.film_id        = r.film_id
WHERE c.name ILIKE 'Multiplex' AND c.district ILIKE 'Франківський'
ORDER BY s.start_time;