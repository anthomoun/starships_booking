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
Starship.destroy_all
User.destroy_all

# Create 5 fake users
5.times do
  User.create!(
    first_name: Faker::Name.first_name,
    email: Faker::Internet.email,
    password: '123456'
  )
end

# Create a bunch of starships
API_URL = 'https://swapi.dev/api/starships/?format=json'.freeze
starships_serialized = URI.open(API_URL).read
starships = JSON.parse(starships_serialized)['results']

# Selection of photos to attach to attach to ships
PHOTOS_URL = ["http://whatsgame.ru/image/o/pb/20b6yzvcqhca6ezo.jpg",
              "https://megagames.com/sites/default/files/game-content-images/x3apswm106f.jpg",
              "https://2.bp.blogspot.com/-16Mr9Oc5ZWk/UomjXXlVgkI/AAAAAAAAK2U/pzVNOvjFjm0/s1600/33.jpg",
              "https://screenshots.gamerinfo.net/x3-albion-prelude/82403.jpg",
              "https://i.ytimg.com/vi/gCCWCOsSBn4/maxresdefault.jpg",
              "https://cdn.mos.cms.futurecdn.net/oC6z7QdfoejyiooPHTKynj.jpg",
              "https://i.ytimg.com/vi/SkBRVEx6KRg/maxresdefault.jpg",
              "https://i.ytimg.com/vi/9SCF-WCDkBw/maxresdefault.jpg",
              "https://static.taigame.org/image/screenshot/201201/x3-albion-prelude-5.jpg",
              "https://oceanof-games.com/games-images/full/x3-albion-prelude/x3-albion-prelude-game-free-download.jpg"]

starships.each do |starship|
  # ONCE SESSIONS ARE IMPLEMENTED, FIX OWNER DESIGNATION
  starship = Starship.create!({ name: starship['name'],
                                starship_type: starship['model'],
                                number_of_persons: starship['passengers'],
                                address: Faker::Address.full_address,
                                price: starship['cost_in_credits'],
                                description: "#{starship['starship_class']}, manufactured by #{starship['manufacturer']}",
                                user: User.all.sample })
  starship.photos.attach(io: URI.open(PHOTOS_URL.sample), filename: 'ship.jpg', content_type: 'image/jpg')
end
