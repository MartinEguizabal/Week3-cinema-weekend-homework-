require_relative('../db/sql_runner')
# require('pry')

class Film

  attr_reader :id
  attr_accessor :title, :price

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

  def update()
    sql = "UPDATE films SET (title, price) = 
    ('#{@title}', #{@price}) WHERE id = #{@id};"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM film WHERE id = #{id};"
    SqlRunner.run(sql)
  end

  def customers_to_see_film()
    sql = "SELECT customers.* FROM customers INNER JOIN tickets ON customers.id = tickets.customer_id WHERE film_id = #{@id};" 
    return Customer.map_items(sql)
  end

  def self.all()
    sql = "SELECT * FROM films;"
    return self.map_items(sql)
  end

  def self.delete_all()
    sql = "DELETE FROM films;"
    SqlRunner.run(sql)
  end

  def self.map_items(sql)
    films = SqlRunner.run(sql)
    result = films.map{|film| Film.new(film)}
    return result
  end

end