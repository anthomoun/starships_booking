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
PHOTOS_EXTERIOR = ["https://res.cloudinary.com/dgfjq6es8/image/upload/v1/development/m4w7jmkndkf9a02oo603n8ngte1w",
                   "https://res.cloudinary.com/dgfjq6es8/image/upload/v1/development/cwiv05qhjvzd48c9d8h9yi64ukj5",
                   "https://res.cloudinary.com/dgfjq6es8/image/upload/v1/development/wxvs76jlekmnztkb07plf3e0wyjk",
                   "https://res.cloudinary.com/dgfjq6es8/image/upload/v1/development/r1zp2xfpl7swqfkn2y503q6ewoax",
                   "http://res.cloudinary.com/dgfjq6es8/image/upload/v1/development/9u78i21jvfg6c4z8lza2urut08fb",
                   "https://cdn.mos.cms.futurecdn.net/oC6z7QdfoejyiooPHTKynj.jpg",
                   "https://i.ytimg.com/vi/SkBRVEx6KRg/maxresdefault.jpg",
                   "https://i.ytimg.com/vi/9SCF-WCDkBw/maxresdefault.jpg",
                   "https://static.taigame.org/image/screenshot/201201/x3-albion-prelude-5.jpg",
                   "https://oceanof-games.com/games-images/full/x3-albion-prelude/x3-albion-prelude-game-free-download.jpg"]

PHOTOS_INTERIOR = ["https://res.cloudinary.com/dgfjq6es8/image/upload/v1/development/cnzneqsobm0x40ahs1p3015q24fz",
                   "https://res.cloudinary.com/dgfjq6es8/image/upload/v1/development/wu1hvqwd53q77y6nw47v1967w1d2",
                   "https://res.cloudinary.com/dgfjq6es8/image/upload/v1/development/mry5es26ni6x3qnz0v7ryoehv0d8",
                   "https://res.cloudinary.com/dgfjq6es8/image/upload/v1/development/x9d1vgoyt03qadh9g3gh15xdrko3",
                   "https://res.cloudinary.com/dgfjq6es8/image/upload/v1/development/glh9xx8lsf8ovi9urdtywcbxef7p",
                   "http://res.cloudinary.com/dgfjq6es8/image/upload/v1/development/tucihtfwmlve2fgakpxvc6ya7afp",
                   "http://res.cloudinary.com/dgfjq6es8/image/upload/v1/development/8ubsdh0dh3d2whh9nuxsadnwq4hh",
                   "https://res.cloudinary.com/dgfjq6es8/image/upload/v1/development/r3wksjeyucqgwkq2vpejk153j5mw",
                   "http://res.cloudinary.com/dgfjq6es8/image/upload/v1/development/7t6glcver3zzn42g03tyb77qdnga",
                   "http://res.cloudinary.com/dgfjq6es8/image/upload/v1/development/9m8yp8zs1hch32olnhuk8o4zzj8h",
                   "http://res.cloudinary.com/dgfjq6es8/image/upload/v1/development/v48x3314p92dzl2jelfuexooya8c",
                   "http://res.cloudinary.com/dgfjq6es8/image/upload/v1/development/ofhwcsgjqgrrh0fga1j72kalw4ih",
                   "http://res.cloudinary.com/dgfjq6es8/image/upload/v1/development/9fr74s45mbusmmx0dn657pow8m7m",
                   "http://res.cloudinary.com/dgfjq6es8/image/upload/v1/development/slwzkftqk91htokeb62h1ky74ump",
                   "http://res.cloudinary.com/dgfjq6es8/image/upload/v1/development/o8mqacubshy94aawrqe9cmmumnwf"]

PHOTOS_BEDROOM = ["http://res.cloudinary.com/dgfjq6es8/image/upload/v1/development/6kfnqkuy7qs9sxrsjehxy67v3l88",
                  "http://res.cloudinary.com/dgfjq6es8/image/upload/v1/development/c8o8ph9yx38yspwp33dkzwg6o0t4",
                  "http://res.cloudinary.com/dgfjq6es8/image/upload/v1/development/ivpmc48xpypxax1x9mijhuts5d7e",
                  "http://res.cloudinary.com/dgfjq6es8/image/upload/v1/development/hoiwzkc2xcww60kjbomp1fqh7uj9",
                  "http://res.cloudinary.com/dgfjq6es8/image/upload/v1/development/mckxxld462a5jrhgig7k38qz6g2x"]

starships.each do |starship|
  # ONCE SESSIONS ARE IMPLEMENTED, FIX OWNER DESIGNATION
  starship = Starship.create!({ name: starship['name'],
                                starship_type: starship['model'],
                                number_of_persons: starship['passengers'],
                                address: ADDRESSES.sample,
                                price: starship['cost_in_credits'],
                                description: "#{starship['starship_class']}, manufactured by #{starship['manufacturer']}",
                                user: User.all.sample })
  starship.photos.attach(io: URI.open(PHOTOS_EXTERIOR.sample), filename: 'exterior')
  starship.photos.attach(io: URI.open(PHOTOS_INTERIOR.sample), filename: 'interior_1')
  starship.photos.attach(io: URI.open(PHOTOS_INTERIOR.sample), filename: 'interior_2')
  starship.photos.attach(io: URI.open(PHOTOS_INTERIOR.sample), filename: 'interior_3')
  starship.photos.attach(io: URI.open(PHOTOS_BEDROOM.sample), filename: 'bedroom')

end
