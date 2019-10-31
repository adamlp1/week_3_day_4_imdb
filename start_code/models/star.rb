require('pg')
require_relative('../db/sql_runner.rb')
class Star


  attr_accessor :first_name, :last_name
  attr_reader :id

  def initialize(options)
    @first_name = options['first_name']
    @last_name = options['last_name']
    @id = options['id'].to_i if options['id']
  end

  def save()
    sql = "INSERT INTO stars (first_name, last_name)
    VALUES ($1, $2)
    RETURNING id;"
    values = [@first_name, @last_name]
    result = SqlRunner.run(sql, values)
    @id = result[0]['id'].to_i
  end

  def update()
    sql = "UPDATE stars SET first_name = $1, last_name = $2 WHERE id = $3;"
      values = [@first_name, @last_name, @id]
      result = SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM stars WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def get_movies()
    sql = "SELECT stars.*, movies.title FROM stars
    INNER JOIN castings
    ON stars.id = castings.star_id
    INNER JOIN movies
    ON movies.id = castings.movie_id
    WHERE stars.id = $1;"
    values = [@id]
    results = SqlRunner.run(sql, values)
    results.map { |result| Star.new(result)}
  end

  def self.delete_all()
    sql = "DELETE FROM stars;"
    stars = SqlRunner.run(sql)
  end

end
