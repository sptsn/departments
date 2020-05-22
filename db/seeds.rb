# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

10.times do
  Employee.create(first_name: Faker::Name.first_name, middle_name: Faker::Name.middle_name, last_name: Faker::Name.last_name)
end


5.times do
  Department.create(name: Faker::Company.name, formed_at: Date.today - rand(0..7).days)
end
