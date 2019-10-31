SELECT stars.*, movies.title FROM stars
INNER JOIN castings
ON stars.id = castings.star_id
INNER JOIN movies
ON movies.id = castings.movie_id;
