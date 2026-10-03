SELECT
    sp.ticket_price AS ticket_price
FROM session s
JOIN session_price sp ON sp.session_id   = s.session_id
JOIN repertoire    r  ON r.repertoire_id = s.repertoire_id
JOIN cinema        c  ON c.cinema_id     = r.cinema_id
JOIN film          f  ON f.film_id       = r.film_id
WHERE c.name ILIKE 'Multiplex'
  AND c.district ILIKE 'Франківський'
  AND f.title ILIKE 'Одіссея'
  AND s.start_time = '2026-09-26 15:00';