SELECT title, rating, length, rental_rate
FROM film
WHERE (rating = 'G' OR rating = 'PG')
  AND special_features = '{Trailers}'
  AND rental_rate < 1
ORDER BY length DESC;

SELECT * from staff;

SELECT rating
FROM film
WHERE title ILIKE '%Kiss%';

SELECT c.first_name, c.last_name, p.amount, p.payment_date
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
JOIN address a ON c.address_id = a.address_id
WHERE p.amount < 5
  AND p.payment_date::date = '2007-02-15'
  AND a.postal_code = '54132';

SELECT c.first_name, c.last_name, r.return_date
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
LEFT JOIN payment p ON r.rental_id = p.rental_id
WHERE f.title = 'Story Side'
    AND p.payment_id IS NULL
ORDER BY r.return_date DESC;

select a.first_name ,a.last_name, COUNT(f.film_id) AS number_of_films
FROM actor a
JOIN film_actor f ON a.actor_id = f.actor_id
GROUP BY a.first_name, a.last_name
HAVING COUNT(f.film_id) > 40
ORDER BY a.last_name asc;

WITH CustomerCTE AS (
    SELECT
        last_name,
        first_name,
        'C' AS type
    FROM
        customer
    WHERE
        last_name LIKE 'S%'
),
StaffCTE AS (
    SELECT
        last_name,
        first_name,
        'S' AS type
    FROM
        staff
    WHERE
        last_name LIKE 'S%'
)
SELECT * FROM CustomerCTE
UNION
SELECT * FROM StaffCTE order by type, first_name asc;

 SELECT
    rental_rate AS rental_rate,
    COUNT(*) AS count,
    AVG(replacement_cost) AS avg,
    MAX(replacement_cost) AS max,
    MIN(replacement_cost) AS min
FROM
    film
GROUP BY
    rental_rate
ORDER BY
    rental_rate DESC;


SELECT
    city.city
FROM
    city
JOIN
    address ON city.city_id = address.city_id
JOIN
    store ON address.address_id = store.address_id
JOIN
    inventory ON store.store_id = inventory.store_id
GROUP BY
    city.city
ORDER BY
    COUNT(*) DESC
LIMIT 1;

SELECT DISTINCT last_name
FROM staff
WHERE last_name NOT IN (
    SELECT DISTINCT last_name
    FROM customer
);

SELECT tablename AS table_name
FROM pg_tables
WHERE schemaname = 'public'
ORDER BY tablename ASC;