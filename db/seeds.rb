# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require "open-uri"
require 'json'
Starship.destroy_all

ADDRESS = %w[Cayenne Marseille Washington Phuket].freeze
url = "https://swapi.dev/api/starships.format=json"

starships_serialized = URI.open(url).read
starships = JSON.parse(starships_serialized)["results"]

starships.each do |starship|
  Starship.create!(
    name: starship['name'],
    type: starship['model'],
    number_of_persons: starship['passengers'],
    address: ADDRESS.sample,
    description: "#{starship['starship_class']}, manufactured by #{starship['manufacturer']}",
    price: starship['cost_in_credits'],
    poster_url: "https://picsum.photos/200/300"
  )
end

puts "created #{Starship.count} starships !"
