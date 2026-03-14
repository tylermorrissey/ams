class Employee < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :role, presence: true

  has_many :assignments
  has_many :projects, through: :assignments
  has_many :time_cards
end
