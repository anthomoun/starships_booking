class Starship < ApplicationRecord
  belongs_to :user
  has_many :bookings
  # validates :name, :number_of_persons, :address, :price, :description, presence: true
  validates :name,  presence: true

end
