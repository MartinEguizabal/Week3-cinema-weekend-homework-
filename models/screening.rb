require_relative('../db/sql_runner')

class Screening

  attr_reader :id, :film_id
  attr_accessor :show_time

  def initialize(options)
    @id = options['id'].to_i
    @film_id = options['film_id'].to_i
    @show_time = options['show_time'].to_i
  end

  def save()
    sql = "INSERT INTO screenings (film_id, show_time) VALUES (#{@film_id}, #{@show_time})
    RETURNING id;"
    screening = SqlRunner.run(sql).first
    @id = screening['id'].to_i
  end

  def most_popular_time()
    sql = "SELECT screenings.* FROM screenings INNER JOIN tickets ON screenings.film_id = tickets.film_id WHERE film_id = ;"
    return Screening.map_items(sql)

  end

  def self.all()
    sql = "SELECT * FROM screenings;"
    return self.map_items(sql)
  end

  def self.delete_all()
    sql = "DELETE FROM screenings;"
    SqlRunner.run(sql)
  end

  def self.map_items(sql)
    screenings = SqlRunner.run(sql)
    result = screenings.map{|screening| Screening.new(screening)}
    return result
  end

end