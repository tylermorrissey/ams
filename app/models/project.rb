class Project < ApplicationRecord
  has_many :assignments, dependent: :destroy
  has_many :employees, through: :assignments
  has_many :vehicles

  validates :customer_name, presence: true
  validates :address, presence: true
  has_many :tools
end
