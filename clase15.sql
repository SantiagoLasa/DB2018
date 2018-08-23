#1
CREATE VIEW list_of_customers AS
SELECT customer_id, CONCAT(first_name, ' ',  last_name), address.address, 
address.postal_code, IF(active=1, "Active", "Inactive") as status, address.phone, city.city,
country.country, store_id
FROM customer
INNER JOIN address USING(address_id)
INNER JOIN city USING(city_id)
INNER JOIN country USING(country_id)

#2

CREATE VIEW film_details AS 
SELECT film.film_id, film.title, film.description, category.name, film.rental_rate, film.`length`, film.rating, 
GROUP_CONCAT(CONCAT(actor.first_name, ' ' ,actor.last_name))
FROM film
INNER JOIN film_category USING(film_id)
INNER JOIN category USING(category_id)
INNER JOIN film_actor USING(film_id)
INNER JOIN actor USING(actor_id)
GROUP BY 1, 4

#3
CREATE VIEW sales_by_film_category AS
SELECT category.name, SUM(payment.amount) AS total_rental
FROM category
INNER JOIN film_category USING(category_id)
INNER JOIN film USING(film_id)
INNER JOIN inventory USING(film_id)
INNER JOIN rental USING(inventory_id)
INNER JOIN payment USING(rental_id)
GROUP BY 1


#4
CREATE VIEW actor_information AS
SELECT actor.actor_id, CONCAT(actor.first_name, ' ', actor.last_name), COUNT(actor_id) AS cant_actuaciones
FROM actor
INNER JOIN film_actor USING(actor_id)
GROUP BY 1
ORDER BY 1 ASC

#5
CREATE DEFINER=CURRENT_USER SQL SECURITY INVOKER VIEW actor_info
AS
SELECT
a.actor_id,
a.first_name,
a.last_name,
GROUP_CONCAT(DISTINCT CONCAT(c.name, ': ',
		(SELECT GROUP_CONCAT(f.title ORDER BY f.title SEPARATOR ', ')
                    FROM sakila.film f
                    INNER JOIN sakila.film_category fc
                      ON f.film_id = fc.film_id
                    INNER JOIN sakila.film_actor fa
                      ON f.film_id = fa.film_id
                    WHERE fc.category_id = c.category_id
                    AND fa.actor_id = a.actor_id
                 )
             )
             ORDER BY c.name SEPARATOR '; ')
AS film_info
FROM sakila.actor a
LEFT JOIN sakila.film_actor fa
  ON a.actor_id = fa.actor_id
LEFT JOIN sakila.film_category fc
  ON fa.film_id = fc.film_id
LEFT JOIN sakila.category c
  ON fc.category_id = c.category_id
GROUP BY a.actor_id, a.first_name, a.last_name;

SELECT * FROM actor_information

#6
#A Materialized View (MV) is the pre-calculated (materialized) 
#result of a query. Unlike a simple VIEW the result of a Materialized 
#View is stored somewhere, generally in a table. Materialized Views are 
#used when immediate response is needed and the query where the Materialized
#View bases on would take to long to produce a result.

#DBMS: oracle, postgreSQL, SQL SERVER, MySQL doesn't support materialized views natively,
#but workarounds can be implemented by using triggers or stored procedures