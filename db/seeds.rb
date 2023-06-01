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
ADDRESSES = %w[paris london madrid mexico marseille]
# Selection of photos to attach to attach to ships
PHOTOS_EXTERIOR = ["http://res.cloudinary.com/dgfjq6es8/image/upload/v1/development/fy5fbbxk44dw9jvs77b6gxiafsf6",
                   "http://res.cloudinary.com/dgfjq6es8/image/upload/v1/development/2cw4uhatwwx1ue89ok83l2y18cd8",
                   "http://res.cloudinary.com/dgfjq6es8/image/upload/v1/development/ydu2cltge6o0adx84o02tjo23t44",
                   "http://res.cloudinary.com/dgfjq6es8/image/upload/v1/development/vbjurgmce3c9t22fhualzb7a3xo1",
                   "http://res.cloudinary.com/dgfjq6es8/image/upload/v1/development/hxc9clyp73vwdn74r4fncnpx4kwd",
                   "https://cdn.mos.cms.futurecdn.net/oC6z7QdfoejyiooPHTKynj.jpg",
                   "https://i.ytimg.com/vi/SkBRVEx6KRg/maxresdefault.jpg",
                   "https://i.ytimg.com/vi/9SCF-WCDkBw/maxresdefault.jpg",
                   "https://static.taigame.org/image/screenshot/201201/x3-albion-prelude-5.jpg",
                   "https://oceanof-games.com/games-images/full/x3-albion-prelude/x3-albion-prelude-game-free-download.jpg"]

PHOTOS_INTERIOR = ["http://res.cloudinary.com/dgfjq6es8/image/upload/v1/development/ur6u5uz85fllxa5qkofupd0w34b5",
                   "http://res.cloudinary.com/dgfjq6es8/image/upload/v1/development/cj500az8bviu4b2ez70sk9g4ruad",
                   "http://res.cloudinary.com/dgfjq6es8/image/upload/v1/development/n8d5lykl4s1fd6f03fcbg2e6d3wh",
                   "http://res.cloudinary.com/dgfjq6es8/image/upload/v1/development/yb4902vbo0dewporpyxzaj9qal6q",
                   "http://res.cloudinary.com/dgfjq6es8/image/upload/v1/development/vbdemvo2o13b49ved9h7tcdasj4x",
                   "http://res.cloudinary.com/dgfjq6es8/image/upload/v1/development/dazib3a3vj8q3pyte9uqz8o5wfnf",
                   "http://res.cloudinary.com/dgfjq6es8/image/upload/v1/development/llv1sp6h9ndjpidh7akc75m8rl1l",
                   "http://res.cloudinary.com/dgfjq6es8/image/upload/v1/development/5oiphk37cvu9uc0run5i5sfcx8ib",
                   "http://res.cloudinary.com/dgfjq6es8/image/upload/v1/development/1m8bn7muv4hdi26t9idirqvtwxlq",
                   "http://res.cloudinary.com/dgfjq6es8/image/upload/v1/development/owhih6zgrlmn6e8nuicpk3p8ycj9",
                   "http://res.cloudinary.com/dgfjq6es8/image/upload/v1/development/x1gy924c96zbbps8ip1aaer37lzt",
                   "http://res.cloudinary.com/dgfjq6es8/image/upload/v1/development/yyv156m1sju2jmgmq6htln7xustj",
                   "http://res.cloudinary.com/dgfjq6es8/image/upload/v1/development/b5mqgjpq6anz2wjd5079k9w4wg6t",
                   "http://res.cloudinary.com/dgfjq6es8/image/upload/v1/development/c2nw54ud3373f1nj8vuw7sg34wi6",
                   "http://res.cloudinary.com/dgfjq6es8/image/upload/v1/development/1y0w7vsy2tb324tsmsk72h0d9ci3",
                   "http://res.cloudinary.com/dgfjq6es8/image/upload/v1/development/glvtzxsol3kpcr74r5wdn85h3ues"]

PHOTOS_BEDROOM = ["http://res.cloudinary.com/dgfjq6es8/image/upload/v1/development/ipjnvtvmytsc0vk82hk2hpkrlw8p",
                  "http://res.cloudinary.com/dgfjq6es8/image/upload/v1/development/wpacj689cp0mxs46bjfy0zspbpb3",
                  "http://res.cloudinary.com/dgfjq6es8/image/upload/v1/development/r1noohgo6yh6xw4d1y7ctn48v6fc",
                  "http://res.cloudinary.com/dgfjq6es8/image/upload/v1/development/c2nw54ud3373f1nj8vuw7sg34wi6",
                  "http://res.cloudinary.com/dgfjq6es8/image/upload/v1/development/q9gcb9jdansh28vnwnhhcow8tjya"]

starships.each do |starship|
  # ONCE SESSIONS ARE IMPLEMENTED, FIX OWNER DESIGNATION
  starship = Starship.create!({ name: starship['name'],
                                starship_type: starship['model'],
                                number_of_persons: starship['passengers'],
                                address: ADDRESSES.sample,
                                price: starship['cost_in_credits'],
                                description: "#{starship['starship_class']}, manufactured by #{starship['manufacturer']}",
                                user: User.all.sample })
  starship.photos.attach(io: URI.open(PHOTOS_EXTERIOR.sample), filename: 'ship.jpg', content_type: 'image/jpg')
  starship.photos.attach(io: URI.open(PHOTOS_INTERIOR.sample), filename: 'ship.jpg', content_type: 'image/jpg')
  starship.photos.attach(io: URI.open(PHOTOS_INTERIOR.sample), filename: 'ship.jpg', content_type: 'image/jpg')
  starship.photos.attach(io: URI.open(PHOTOS_INTERIOR.sample), filename: 'ship.jpg', content_type: 'image/jpg')
  starship.photos.attach(io: URI.open(PHOTOS_BEDROOM.sample), filename: 'ship.jpg', content_type: 'image/jpg')

end
