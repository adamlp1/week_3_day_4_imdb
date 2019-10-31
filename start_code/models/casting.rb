require('pg')
require_relative('../db/sql_runner.rb')
class Casting

  attr_accessor :fee
  attr_reader :id, :movie_id, :star_id

  def initialize(options)
    @fee = options['fee']
    @id = options['id'].to_i if options['id']
    @movie_id = options['movie_id'].to_i
    @star_id = options['star_id'].to_i
  end

  def save()
    sql = "INSERT INTO castings (fee, movie_id, star_id)
    VALUES ($1, $2, $3)
    RETURNING id;"
    values = [@fee, @movie_id, @star_id]
    results = SqlRunner.run(sql, values)
    @id = results[0]['id'].to_i
  end

  def delete()
    sql = "DELETE FROM castings WHERE id = $1;"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.delete_all()
    sql = "DELETE FROM castings;"
    castings = SqlRunner.run(sql)
  end

  def update()
    sql = "UPDATE castings SET fee = $1, movie_id = $2, star_id = $3 WHERE id = $4;"
      values = [@fee, @movie_id, @star_id, @id]
      result = SqlRunner.run(sql, values)
  end

end
