class Project < ApplicationRecord
  has_many :assignments, dependent: :destroy
  has_many :employees, through: :assignments
  has_many :vehicles
  has_many :assigned_tools, dependent: :destroy
  has_many :tools, through: :assigned_tools
  accepts_nested_attributes_for :assigned_tools

  validates :customer_name, presence: true
  validates :address, presence: true
end
