1)

INSERT INTO sakila.customer
(store_id, first_name, last_name, email, address_id, active,  last_update)
VALUES(1, 'Santiago', 'Lasa', 'santi.lasa@gmail.com', (SELECT address_id
FROM address 
INNER JOIN city USING(city_id)
INNER JOIN country USING(country_id)
WHERE country= "United States"
order by address_id DESC
LIMIT 1), 1, CURRENT_TIMESTAMP);

SELECT address_id
FROM address 
INNER JOIN city USING(city_id)
INNER JOIN country USING(country_id)
WHERE country= "United States"
order by address_id DESC
LIMIT 1;

2)

INSERT INTO sakila.rental
(inventory_id, customer_id, staff_id, last_update)
VALUES(
	(SELECT inventory_id FROM inventory INNER JOIN film USING(film_id) WHERE title = "ACADEMY DINOSAUR" ORDER by film_id DESC LIMIT 1),
	(SELECT customer_id FROM customer WHERE store_id = 2 limit 1), 
	(SELECT staff_id from staff WHERE store_id = 2 limit 1),
	CURRENT_TIMESTAMP);

SELECT staff_id
from staff
WHERE store_id = 2
limit 1;

SELECT customer_id 
FROM customer 
WHERE store_id = 2 
limit 1

SELECT inventory_id
FROM inventory 
INNER JOIN film USING(film_id)
WHERE title = "ACADEMY DINOSAUR"
LIMIT 1;

3)

UPDATE sakila.film
SET release_year= CASE
	WHEN rating = 'PG' THEN 2001
	WHEN rating = 'PG-13' THEN 2004
	WHEN rating = 'G' THEN 2003
	WHEN rating = 'R' THEN 2009
	WHEN rating = 'NC-17' THEN 2002
	END
	
4)

select title, rental_id, rental_date, return_date
FROM film
INNER JOIN inventory USING (film_id)
left OUTER JOIN rental USING(inventory_id)
where return_date is NULL
ORDER BY rental_date DESC
limit 1;

UPDATE rental
SET return_date = CURRENT_DATE
WHERE rental_id= 14531;

5)

de error por todas las FOREIGN key que tiene la pelicula

DELETE payment FROM payment
INNER JOIN rental USING(rental_id)
INNER JOIN inventory USING (inventory_id)
WHERE film_id=1;

DELETE rental FROM rental
INNER JOIN inventory USING (inventory_id)
WHERE film_id=1;

DELETE inventory FROM inventory
WHERE film_id=1;

DELETE FROM film_category
WHERE film_id=1;

delete from film_actor
where film_id=1;

DELETE FROM film
WHERE film_id= 1


6)


SELECT inventory_id , rental_id, store_id
from film
INNER JOIN inventory USING (film_id)
INNER JOIN rental USING (inventory)
rental.return_date 

SELECT CURRENT_TIMESTAMP,
	t1.inventory_id,
	customer.customer_id,
	NULL,
	t1.staff_id
FROM customer
INNER JOIN (SELECT stor)





