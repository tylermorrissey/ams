class Tool < ApplicationRecord
  has_many :assigned_tools, dependent: :destroy
  has_many :projects, through: :assigned_tools
  validates :name, presence: true
  validates :make, presence: true
  validates :model, presence: true
end
