require_relative('../db/sql_runner')
# require('pry')

class Film

  attr_reader :id, :title, :price

  def initialize(options)
    @id = options['id'].to_i
    @title = options['title']
    @price = options['price'].to_i
  end

  def save()
    sql = "INSERT INTO films (title, price) VALUES ('#{@title}', #{@price}) RETURNING id"
    film = SqlRunner.run(sql).first
    # binding.pry
    @id = film['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM films;"
    return self.map_items(sql)
  end

  def self.map_items(sql)
    films = SqlRunner.run(sql)
    result = films.map{|film| Film.new(film)}
    return result
  end

end