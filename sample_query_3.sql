SELECT
    h.capacity - COUNT(t.ticket_id) FILTER (WHERE t.status IN ('Sold', 'Booked')) AS free_seats
FROM session s
JOIN hall   h ON s.hall_id = h.hall_id
JOIN cinema c ON h.cinema_id = c.cinema_id
JOIN film   f ON s.film_id  = f.film_id
LEFT JOIN ticket t ON t.session_id = s.session_id
WHERE c.name ILIKE 'Multiplex'
  AND c.district ILIKE 'Франківський'
  AND f.title ILIKE 'Людина-павук: Абсолютно новий день'
  AND s.start_time = '2026-09-25 14:00'
GROUP BY c.name, c.district, f.title, s.start_time, h.capacity;