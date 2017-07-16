require_relative('../models/customer')
require_relative('../models/film')
require_relative('../models/ticket')

require('pry')

Film.delete_all
Customer.delete_all
Ticket.delete_all

film1 = Film.new({'title' => 'There will be blood', 'price' => 9})
film1.save()

film2 = Film.new({'title' => 'Taken', 'price' => 7})
film2.save()

film3 = Film.new({'title' => 'Star Wars: The Empire Strikes back', 'price' => 15})
film3.save()

customer1 = Customer.new({'name' => 'Marty Eggsalots', 'funds' => 20})
customer1.save()

customer2 = Customer.new({'name' => 'Samwise', 'funds' => 15})
customer2.save()

customer3 = Customer.new({'name' => 'Sally', 'funds' => 14})
customer3.save()

ticket1 = Ticket.new({'film_id' => film1.id, 'customer_id' => customer3.id})
ticket1.save()

ticket2 = Ticket.new({'film_id' => film2.id, 'customer_id' => customer1.id})
ticket2.save()

ticket3 = Ticket.new({'film_id' => film3.id, 'customer_id' => customer2.id})
ticket3.save()

binding.pry
nil