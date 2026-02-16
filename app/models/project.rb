class Project < ApplicationRecord
  has_many :employees, through: :assignments
  has_many :vehicles
end
