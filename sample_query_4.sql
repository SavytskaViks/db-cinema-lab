SELECT
    s.base_price AS ticket_price
FROM session s
JOIN hall   h ON s.hall_id = h.hall_id
JOIN cinema c ON h.cinema_id = c.cinema_id
JOIN film   f ON s.film_id  = f.film_id
WHERE c.name ILIKE 'Multiplex'
  AND c.district ILIKE 'Франківський'
  AND f.title ILIKE 'Одіссея'
  AND s.start_time = '2026-09-26 15:00';