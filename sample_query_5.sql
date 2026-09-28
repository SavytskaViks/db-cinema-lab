SELECT
    f.director                                 AS director,
    STRING_AGG(DISTINCT g.name, ', ')          AS genres,
    STRING_AGG(DISTINCT co.name, ', ')         AS production_countries
FROM film f
LEFT JOIN film_genre   fg ON fg.film_id = f.film_id
LEFT JOIN genre        g  ON g.genre_id = fg.genre_id
LEFT JOIN film_country fc ON fc.film_id = f.film_id
LEFT JOIN country      co ON co.country_id = fc.country_id
WHERE f.title ILIKE 'Людина-павук: Абсолютно новий день'
GROUP BY f.title, f.director;