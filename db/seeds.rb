# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user1 = User.create(email:"scottyh527@gmail.com", username: "scottyh527", password: "Shuang!")
event1 = Event.create(title:"Example", description:"Example for other stuff", location:"OH MY", user_id: 2)
