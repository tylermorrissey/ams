class Vehicle < ApplicationRecord
  validates :year, presence: true
  validates :model, presence: true
  valdiates :nick_name, presence: true, uniqueness: true

  has_many :project_vehicles
  
end
