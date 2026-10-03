SELECT
    c.district  AS district,
    c.address   AS address
FROM cinema c
WHERE c.name ILIKE 'Планета Кіно';