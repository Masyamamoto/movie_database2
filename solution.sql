CREATE TABLE query1 AS
SELECT genres.name, count(hasagenre.movieid) as moviecount
FROM hasagenre, genres
WHERE hasagenre.genreid=genres.genreid
GROUP BY genres.name;

CREATE TABLE query2 AS
SELECT genres.name, AVG(ratings.rating) as rating
FROM hasagenre, genres, ratings
WHERE hasagenre.genreid=genres.genreid AND ratings.movieid=hasagenre.movieid
GROUP BY genres.name;

CREATE TABLE query3 AS
SELECT movies.title, COUNT(ratings.rating) as countofratings
FROM movies, ratings
WHERE movies.movieid=ratings.movieid
GROUP BY movies.title
HAVING COUNT(ratings.rating)>=10;

CREATE TABLE query4 AS
SELECT movies.movieid, movies.title
FROM movies, hasagenre, genres
WHERE movies.movieid=hasagenre.movieid
AND hasagenre.genreid=genres.genreid
AND genres.name='Comedy';

CREATE TABLE query5 AS
SELECT movies.title, AVG(ratings.rating) AS average
FROM movies, ratings
WHERE movies.movieid=ratings.movieid
GROUP BY movies.title;

CREATE TABLE query6 AS
SELECT AVG(ratings.rating) AS average
FROM genres, hasagenre, movies, ratings
WHERE genres.genreid=hasagenre.genreid
AND hasagenre.movieid=movies.movieid
AND movies.movieid=ratings.movieid
AND genres.name='Comedy';

CREATE TABLE query7 AS
SELECT AVG(ratings.rating) AS average
FROM movies, ratings
WHERE movies.movieid=ratings.movieid
AND movies.title in (SELECT movies.title
					 FROM genres, hasagenre, movies, ratings
					 WHERE genres.genreid=hasagenre.genreid
					 AND hasagenre.movieid=movies.movieid
					 AND (genres.name='Comedy' OR genres.name='Romance')
					 GROUP BY movies.title
					 HAVING COUNT(DISTINCT genres.name)>=2);

 CREATE TABLE query8 AS
 SELECT AVG(ratings.rating) AS average
 FROM movies, ratings
 WHERE movies.movieid=ratings.movieid
 AND movies.title in (SELECT t1.title
 					 FROM (SELECT movies.title
 						   FROM genres, hasagenre, movies
 						   WHERE genres.genreid=hasagenre.genreid
 						   AND hasagenre.movieid=movies.movieid
 						   AND genres.name='Romance') AS t1
 					 LEFT JOIN (SELECT movies.title
 								FROM genres, hasagenre, movies
 								WHERE genres.genreid=hasagenre.genreid
 								AND hasagenre.movieid=movies.movieid
 								AND genres.name='Comedy') AS t2
 					 ON t1.title = t2.title
 					 WHERE t2.title is NULL);

 CREATE TABLE query9 AS
 SELECT movies.movieid, ratings.rating
 FROM movies, ratings, users
 WHERE movies.movieid=ratings.movieid
 AND ratings.userid=users.userid
 AND users.userid=:v1;
