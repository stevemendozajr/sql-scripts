-- use database
USE sakila;

-- la 
SELECT first_name, last_name
FROM actor;

-- 1b
SELECT concat(first_name,' ',last_name) AS Actor
FROM actor;

-- 2a
SELECT *
FROM actor
WHERE first_name='Joe';

-- 2b
SELECT *
FROM actor
WHERE last_name LIKE '%GEN%';

-- 2c
SELECT *
FROM actor
WHERE last_name LIKE '%LI%'
ORDER BY last_name,first_name ASC;

-- 2d
SELECT country_id,country
FROM country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

-- 3a
ALTER TABLE actor
ADD description BLOB;

-- 3b
ALTER TABLE actor
DROP COLUMN description;

-- 4a
SELECT last_name, COUNT(last_name) AS 'num of actors'
FROM actor
GROUP BY last_name;

-- 4b
SELECT last_name, COUNT(last_name) AS 'num of actors'
FROM actor
GROUP BY last_name
HAVING COUNT(last_name) > 1;

-- 4c
SELECT *
FROM actor
WHERE last_name = 'Williams';

UPDATE actor
SET first_name = 'HARPO'
WHERE actor_id=172;

-- 4d
UPDATE actor
SET first_name = 'GROUCHO'
WHERE actor_id=172;

-- 5a
SHOW CREATE TABLE address;

-- 6a
SELECT s.first_name,s.last_name,a.address
FROM staff s
JOIN address a ON s.address_id=a.address_id;

-- 6b
SELECT s.first_name,s.staff_id, SUM(p.amount) AS 'total amount rung'
FROM staff s
JOIN payment p ON s.staff_id=p.staff_id
WHERE payment_date LIKE '2005-08%'
GROUP BY s.staff_id;

-- 6c
SELECT f.title,COUNT(fa.actor_id) AS 'number of actors'
FROM film_actor fa
INNER JOIN film f ON f.film_id=fa.film_id
GROUP BY f.title;

-- 6d
SELECT f.title,COUNT(i.inventory_id) AS 'number of copies'
FROM film f
INNER JOIN inventory i ON f.film_id=i.film_id
WHERE f.title = 'Hunchback Impossible';

-- 6e
SELECT c.first_name,c.last_name,SUM(p.amount) AS 'total amount paid'
FROM customer c
JOIN payment p ON c.customer_id=p.customer_id
GROUP BY c.first_name, c.last_name
ORDER BY c.last_name ASC;

-- 7a
SELECT title
FROM film
WHERE language_id IN
	(
	SELECT language_id
	FROM language
	WHERE name = 'English'
	);
    
-- 7b
SELECT first_name,last_name
FROM actor
WHERE actor_id IN 
	(
	SELECT actor_id
	FROM film_actor
	WHERE film_id IN 
		(
		SELECT film_id
		FROM film
		WHERE title = 'Alone Trip'
		)
	);
    
-- 7c
SELECT first_name,last_name,email
FROM customer c
INNER JOIN customer_list cl ON c.customer_id=cl.ID
WHERE cl.country = 'Canada';

-- 7d
SELECT title
FROM film
WHERE film_id IN 
	(
	SELECT film_id
	FROM film_category
	WHERE category_id IN 
		(
		SELECT category_id
		FROM category
		WHERE name = 'Family'
		)
	);
    
-- 7e
SELECT f.title, COUNT(r.rental_id) AS 'Total Times Rented'
FROM rental r
JOIN inventory i
ON (r.inventory_id = i.inventory_id)
JOIN film f
ON (i.film_id = f.film_id)
GROUP BY f.title
ORDER BY COUNT(r.rental_id) DESC;

-- 7f
SELECT s.store_id, SUM(amount) AS Gross
FROM payment p
JOIN rental r
ON (p.rental_id = r.rental_id)
JOIN inventory i
ON (i.inventory_id = r.inventory_id)
JOIN store s
ON (s.store_id = i.store_id)
GROUP BY s.store_id;

-- 7g
SELECT s.store_id,c.city,co.country
FROM store s
JOIN address a
ON (s.address_id=a.address_id)
JOIN city c
ON (c.city_id=a.city_id)
JOIN country co
ON (co.country_id=c.country_id);

-- 7h
SELECT ca.name,SUM(p.amount) AS 'Gross Revenue'
FROM category ca
JOIN film_category fc ON (fc.category_id=ca.category_id)
JOIN inventory i ON (i.film_id=fc.film_id)
JOIN rental r ON (r.inventory_id=i.inventory_id)
JOIN payment p ON (p.rental_id=r.rental_id)
GROUP BY ca.name
ORDER BY SUM(p.amount) DESC
LIMIT 5;

-- 8a
CREATE VIEW v_top_5_genre_gross_rev
AS
SELECT ca.name,SUM(p.amount) AS 'Gross Revenue'
FROM category ca
JOIN film_category fc ON (fc.category_id=ca.category_id)
JOIN inventory i ON (i.film_id=fc.film_id)
JOIN rental r ON (r.inventory_id=i.inventory_id)
JOIN payment p ON (p.rental_id=r.rental_id)
GROUP BY ca.name
ORDER BY SUM(p.amount) DESC
LIMIT 5;

-- 8b
select * from v_top_5_genre_gross_rev;

-- 8c
DROP VIEW v_top_5_genre_gross_rev;




































































