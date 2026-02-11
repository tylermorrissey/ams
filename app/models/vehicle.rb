class Vehicle < ApplicationRecord
  validates :year, presence: true
  validates :model, presence: true
  validates :nick_name, presence: true, uniqueness: true

  has_many :project_vehicles
  
end
