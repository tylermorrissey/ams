class Project < ApplicationRecord
  has_many :employees, through: :employees_onsite
  has_many :vehicles
end
