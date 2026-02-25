class Project < ApplicationRecord
  has_many :assignments
  has_many :employees, through: :assignments
  has_many :vehicles

  validates :customer_name, presence: true
  validates :address, presence: true
end
