# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'
require 'open-uri'
require 'json'

# Purge database
User.destroy_all
Starship.destroy_all

# Create 5 fake users
5.times do
  User.create!(
    first_name: Faker::Name.first_name,
    email: Faker::Internet.email,
    password: '123456'
  )
end

# Create a bunch of starships
API_URL = 'https://swapi.dev/api/starships/?format=json'
starships_serialized = URI.open(API_URL).read
starships = JSON.parse(starships_serialized)['results']

starships.each do |starship|
  Starship.create!({ name: starship['name'],
                     model: starship['model'],
                     number_of_persons: starship['passengers'],
                     address: Faker::Address.full_address,
                     price: starship['cost_in_credits'],
                     description: "#{starship['starship_class']}, manufactured by #{starship['manufacturer']}" })
end
