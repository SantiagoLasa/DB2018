1)

SELECT first_name,last_name 
FROM actor a1 
WHERE EXISTS (SELECT * 
FROM actor a2 
WHERE a1.last_name = a2.last_name 
AND a1.actor_id <> a2.actor_id)
ORDER by last_name;

2)

SELECT a1.first_name, a1.last_name
FROM actor a1
WHERE NOT EXISTS ( SELECT *
FROM film_actor fa2
WHERE fa2.actor_id = a1.actor_id)

SELECT rental_id from rental where customer_id =318;
DELETE from rental where rental_id <> 650 and customer_id=318;

3)

SELECT c1.customer_id, c1.first_name, c1.last_name
FROM rental r1, customer c1
WHERE c1.customer_id = r1.customer_id
AND NOT EXISTS ( select *
FROM rental r2
WHERE r1.customer_id = r2.customer_id
and r1.rental_id <> r2.rental_id);


4)

SELECT c1.customer_id, c1.first_name, c1.last_name
FROM rental r1, customer c1
WHERE c1.customer_id = r1.customer_id
AND EXISTS ( select *
FROM rental r2
WHERE r1.customer_id = r2.customer_id
and r1.rental_id <> r2.rental_id);

SELECT customer_id, COUNT(1)
from rental
group by 1
order by 2;

5)

SELECT a1.first_name, f1.title
FROM actor a1, film f1
WHERE EXISTS(
SELECT *
FROM film_actor fa, film f2
WHERE a1.actor_id = fa.actor_id
AND fa.film_id = f2.film_id
AND f1.title IN ('BETRAYED REAR', 'CATCH AMISTAD')
);

6)

SELECT a1.first_name, f1.title
FROM actor a1, film f1
WHERE EXISTS(
SELECT *
FROM film_actor fa, film f2
WHERE a1.actor_id = fa.actor_id
AND fa.film_id = f2.film_id
AND f1.title IN ('BETRAYED REAR')
AND f1.title not in ('CATCH AMISTAD')
);

7)

SELECT a1.first_name, f1.title
FROM actor a1, film f1
WHERE EXISTS(
SELECT *
FROM film_actor fa, film f2
WHERE a1.actor_id = fa.actor_id
AND fa.film_id = f2.film_id
AND f1.title = "BETRAYED REAR"
AND f1.title = "CATCH AMISTAD"
);

8)

SELECT a1.first_name, f1.title
FROM actor a1, film f1
WHERE EXISTS(
SELECT *
FROM film_actor fa, film f2
WHERE a1.actor_id = fa.actor_id
AND fa.film_id = f2.film_id
AND f1.title <> "BETRAYED REAR"
AND f1.title <> "CATCH AMISTAD"
);

