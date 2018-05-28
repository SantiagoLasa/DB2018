1)

SELECT  co.country, COUNT(ci.city) as "numero de ciudades"
from country co, city ci
WHERE co.country_id = ci.country_id
GROUP by country
ORDER by country;

SELECT country.country, COUNT(city.city) as "numero_de_ciudades"
FROM country
INNER JOIN city USING ( country_id)
GROUP by country.country, country. country_id
ORDER by country, COUNT(city.city);


2)

SELECT  co.country, COUNT(ci.city) as "numero de ciudades"
from country co, city ci
WHERE co.country_id = ci.country_id
GROUP by country
HAVING COUNT(ci.city) > 10
ORDER by COUNT(ci.city);

SELECT COUNT(city_id), country.country
FROM country
INNER JOIN city USING (country_id)
GROUP by country.country
HAVING COUNT(city_id) > 10
ORDER BY 1 DESC;



3)

SELECT c.first_name, c.last_name, a.address, COUNT(p.rental_id) as "total films rented" ,sum(p.amount) as "total $ spent"
FROM customer c,address a, payment p, rental r
WHERE c.address_id= a.address_id and c.customer_id = r.customer_id and p.rental_id = r.rental_id
GROUP BY p.customer_id, c.last_name, c.first_name, a.address
ORDER by "total $ spent" DESC;

SELECT customer.first_name, customer.last_name, address.address, count(rental.rental_id), SUM(payment.amount)
FROM customer
INNER JOIN address USING(address_id)
INNER JOIN rental USING (customer_id)
INNER JOIN payment USING (rental_id)
GROUP by 1,2,3
ORDER by SUM(payment.amount);

4)

SELECT title
FROM film
WHERE film_id NOT IN (SELECT film_id FROM inventory)
ORDER by film_id;

5)

SELECT f.title 
from film f, inventory i 
where f.film_id = i.film_id
and f.film_id IN (SELECT film_id FROM inventory)
and f.title not in (SELECT DISTINCT f.title FROM film f, inventory i, rental r
WHERE f.film_id = i.film_id and i.inventory_id = r.inventory_id);

select film.title, inventory.inventory_id
FROM film
INNER JOIN inventory USING (film_id)
left OUTER JOIN rental USING(inventory_id)
where rental.rental_id is NULL;



6)

SELECT  c.first_name, c.last_name, s.store_id, f.title, r.rental_date, r.return_date
from customer c, store s, film f, rental r, inventory i
WHERE c.customer_id = r.customer_id 
and i.film_id = f.film_id
and r.inventory_id = i.inventory_id
and c.store_id = s.store_id
and s.store_id = i.store_id
ORDER BY f.film_id, c.last_name;
							

SELECT store.store_id,  customer.last_name, customer.first_name, film.title, rental.rental_date, rental.return_date
FROM store
INNER JOIN customer USING (store_id)
INNER JOIN rental USING (customer_id)
INNER JOIN inventory USING (inventory_id)
INNER JOIN film USING (film_id)
where rental.return_date is not null
ORDER BY store_id, last_name;


7)

SELECT city.city, country.country, staff.first_name, staff.last_name, sum(amount), store.manager_staff_id
from country
INNER JOIN city USING (country_id)
INNER JOIN address USING (city_id)
INNER JOIN store USING (address_id)
INNER JOIN staff on staff.staff_id = store.manager_staff_id
INNER JOIN rental USING (staff_id)
INNER JOIN payment USING (rental_id)
GROUP BY 1,2,3,4,6;

8)

SELECT film.rating , SUM(amount)
from film
INNER JOIN inventory USING (film_id)
INNER JOIN rental USING (inventory_id)
INNER JOIN payment USING (rental_id)
GROUP BY 1;


9)

SELECT actor.actor_id,  actor.first_name, actor.last_name, COUNT(1) as "film_count"
FROM actor JOIN film_actor USING (actor_id)
GROUP BY 1,2,3 DESC
ORDER by film_count des
LIMIT 1;

10)

SELECT category.name, AVG(film.`length`) as "duracion"
from category
INNER JOIN film_category USING (category_id)
INNER JOIN film USING (film_id)
GROUP by 1
HAVING duracion > (SELECT AVG(film.`length`) from film)
ORDER BY duracion DESC;



