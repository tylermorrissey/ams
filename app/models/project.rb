class Project < ApplicationRecord
  has_many :assignments
  has_many :employees, through: :assignments
  has_many :vehicles
  has_many :tools
end
