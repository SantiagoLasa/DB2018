2)

CREATE TABLE films
( film_id INT(11) NOT NULL AUTO_INCREMENT,
  titulo VARCHAR(30) NOT NULL,
  descripcion VARCHAR(25),
  año_de_lanzamiento DATE,
  CONSTRAINT films_pk PRIMARY KEY (film_id)
);

CREATE TABLE actores
( actor_id INT(11) NOT NULL AUTO_INCREMENT,
  first_name VARCHAR(30) NOT NULL,
  last_name VARCHAR(25),
  CONSTRAINT actores_pk PRIMARY KEY (actor_id)
);

CREATE TABLE film_actor
( film_actor_id INT(11) NOT NULL AUTO_INCREMENT,
  actor_id INT(30) NOT NULL,
  film_id VARCHAR(25),
  CONSTRAINT film_actor_pk PRIMARY KEY (film_actor_id)
);

ALTER TABLE film_actor
  MODIFY film_id int(30) NOT NULL;

4)

ALTER TABLE film_actor ADD 
  CONSTRAINT fk_actor
    FOREIGN KEY (actor_id)
    REFERENCES actores (actor_id);

ALTER TABLE film_actor ADD 
  CONSTRAINT fk_film
    FOREIGN KEY (film_id)
    REFERENCES films (film_id);

3)

ALTER TABLE films 
  ADD last_update VARCHAR(50) NULL;
  
ALTER TABLE actores
  ADD last_update VARCHAR(50) NULL;

5)

INSERT INTO imdb.actores
(first_name, last_name, last_update)
VALUES('manuel', 'vargas', 'qcyo');

INSERT INTO imdb.actores
(first_name, last_name, last_update)
VALUES('juan', 'carloz', 'xxl');

INSERT INTO imdb.actores
(first_name, last_name, last_update)
VALUES('julian', 'abba', 'en la estrella');

INSERT INTO imdb.films
(titulo, descripcion, año_de_lanzamiento, last_update)
VALUES('en la estrella', 'alta peli', '1968/03/06', 'llll');

INSERT INTO imdb.films
(titulo, descripcion, año_de_lanzamiento, last_update)
VALUES('el mas largo', 'aterradora historia', '2495/12/03', 'sadsadf');

INSERT INTO imdb.films
(titulo, descripcion, año_de_lanzamiento, last_update)
VALUES('en la montaña', 'historia de suspenso', '2000/11/09', 'sdfs');

INSERT INTO imdb.film_actor
(actor_id, film_id)
VALUES(1, 1);

INSERT INTO imdb.film_actor
(actor_id, film_id)
VALUES(2, 3);

INSERT INTO imdb.film_actor
(actor_id, film_id)
VALUES(4, 2);
