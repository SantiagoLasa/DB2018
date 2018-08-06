1)

SELECT CONCAT( first_name," ", last_name) as "Nombre y apellido", city, country
from customer 
INNER JOIN address USING (address_id)
inner join city USING (city_id)
INNER JOIN country USING (country_id)
where country = "Argentina";


2)

SELECT title ,name,  CASE 
WHEN rating = 'PG' THEN "Parental Guidance Suggested"
	WHEN rating = 'PG-13' THEN "Parents Strongly Cautioned"
	WHEN rating = 'G' THEN "General Audiences"
	WHEN rating = 'R' THEN "Restricted"
	WHEN rating = 'NC-17' THEN "Adults Only"
	end as "rating"
	from film INNER JOIN `language` USING (language_id);

3)
Write a search query that shows all the films (title and release year) an actor 
was part of. Assume the actor comes 
from a text box introduced by hand from a web page. 
Make sure to "adjust" the input text 
to try to find the films as effectively as you think is possible. 

SELECT title, release_year, first_name
from film 
inner join film_actor USING (film_id)
INNER JOIN actor USING (actor_id)
WHERE TRIM(LOWER(CONCAT(actor.first_name))) LIKE TRIM(LOWER('PENELOPE'));

4)
Find all the rentals done in the months of May and June. Show the film title, customer name and if it was returned or not. 
There should be returned column with two possible values 'Yes' and 'No'.

SELECT title, first_name, rental.rental_date, case 
WHEN rental.return_date IS NULL THEN 'No' else 'yes'
end as returned
from film
INNER JOIN inventory USING (film_id)
INNER JOIN rental USING (inventory_id)
INNER JOIN customer USING (customer_id)
WHERE (MONTHNAME(rental.rental_date)='May' or MONTHNAME(rental.rental_date)='February');

5)

Investigate CAST and CONVERT functions. Explain the differences if any, write examples based on sakila DB.

hacen basicamente lo mismo, convierten un tipo de dato a otro tipo de dato.

SELECT CAST(amount as INT) from payment;
SELECT CONVERT(release_year, char CHARACTER set utf8) from film;

6)

esta funcion se usa para setear un balor en caso de error
solo ifnull() y COALESCE() no existen en sql 

en este ejemplo en ves de devolver un valor NULL devuelve un mensaje que dice no devuelta.
SELECT infull(return_date, "no devuelta") FROM rental

esto va a cambiar la peliculas no devueltas a devueltas con fecha de hoy
UPDATE rental SET return_date = COALESCE(return_date, now());

