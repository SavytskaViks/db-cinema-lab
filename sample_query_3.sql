SELECT
    h.capacity - COUNT(t.ticket_id) FILTER (WHERE t.status IN ('Sold', 'Booked')) AS free_seats
FROM session s
JOIN repertoire r ON r.repertoire_id = s.repertoire_id
JOIN hall   h ON h.hall_id   = s.hall_id
JOIN cinema c ON c.cinema_id = r.cinema_id
JOIN film   f ON f.film_id   = r.film_id
LEFT JOIN ticket t ON t.session_id = s.session_id
WHERE c.name ILIKE 'Multiplex'
  AND c.district ILIKE 'Франківський'
  AND f.title ILIKE 'Людина-павук: Абсолютно новий день'
  AND s.start_time = '2026-09-25 14:00'
GROUP BY c.name, c.district, f.title, s.start_time, h.capacity;