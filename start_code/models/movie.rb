require('pg')
require_relative('../db/sql_runner.rb')

class Movie

  attr_accessor :title, :genre
  attr_reader :id

  def initialize(options)
    @title = options['title']
    @genre = options['genre']
    @id = options['id'].to_i if options['id']
  end

  def save()
    sql = "INSERT INTO movies (title, genre)
    VALUES ($1, $2)
    RETURNING id;"
    values = [@title, @genre]
    results = SqlRunner.run(sql, values)
    @id = results[0]['id'].to_i
  end

  def update()
    sql = "UPDATE movies SET title = $1, genre = $2 WHERE id = $3;"
      values = [@title, @genre, @id]
      result = SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM movies WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def get_stars()
    sql = "SELECT stars.*, movies.title FROM movies
    INNER JOIN castings
    ON movies.id = castings.movie_id
    INNER JOIN stars
    ON stars.id = castings.star_id
    WHERE movies.id = $1;"
    values = [@id]
    results = SqlRunner.run(sql, values)
    results.map { |result| Star.new(result)}
  end


  def self.delete_all()
    sql = "DELETE FROM movies;"
    movies = SqlRunner.run(sql)
  end

end
