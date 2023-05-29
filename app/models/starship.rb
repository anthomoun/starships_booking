class Starship < ApplicationRecord
  belongs_to :user_id
  validates :name, :number_of_persons, :address, :price, :description, presence: true
  
end
