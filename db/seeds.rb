# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(name: "Mendel")
User.create(name: "Tom")
User.create(name: "Fred")

Space.create(longitude: -74.014000,latitude: 40.705742)
Space.create(longitude: -74.014260,latitude: 40.705280)
Space.create(longitude: -73.997010,latitude: 40.713670)

UserSpace.create(user_id: User.find(1).id, space_id: Space.find(1).id)
UserSpace.create(user_id: User.find(2).id, space_id: Space.find(2).id)
UserSpace.create(user_id: User.find(3).id, space_id: Space.find(3).id)
