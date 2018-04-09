1)
SELECT f.title, f.special_features 
FROM film f 
WHERE f.rating LIKE "PG-13"

2)
SELECT f1.title, f2.title, f1.`length` 
  FROM film f1, film f2
WHERE f1.`length` <> f2.`length`

3)
SELECT f.title, f.rental_rate, f.replacement_cost
	FROM film f 
where f.replacement_cost BETWEEN 20 and 24

4)
SELECT f.title, c.name, f.rating, f.special_features
 FROM film f, film_category fc,  category c 
WHERE f.special_features LIKE "Behind the scenes";

5)
SELECT a.first_name, a.last_name , f.title
FROM actor a, film_d the manager first/last name of this store (actor fa, film f
WHERE f.title LIKE "ZOOLANDER FICTION";

6)
SELECT  ad.address, co.country, ci.city, s.store_id
FROM country co , city ci , address ad, store s
WHERE s.store_id=1

7)
SELECT f1.title, f2.title, f1.rating, f2.rating
FROM film f1, film f2
WHERE f1.rating = f2.rating;

8)
SELECT f.title, st.first_name, st.last_name
FROM film f, store s, inventory i, staff st
WHERE s.store_id=2 





