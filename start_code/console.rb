require('pry')
require_relative('./models/casting.rb')
require_relative('./models/movie.rb')
require_relative('./models/star.rb')
Casting.delete_all()
Star.delete_all()
Movie.delete_all()

movie1 = Movie.new({
  'title' => 'Matrix',
  'genre' => 'Thriller'
  })
  movie1.save()

  movie2 = Movie.new({
    'title' => 'LOTR',
    'genre' => 'Thriller'
    })
    movie2.save()


star1 = Star.new({
  'first_name' => 'Richard',
  'last_name' => 'Dreyfuss'
  })
star1.save()

casting1 = Casting.new({
  'fee' => 100000,
  'movie_id' => movie1.id,
  'star_id' => star1.id
  })
casting1.save



binding.pry
nil
