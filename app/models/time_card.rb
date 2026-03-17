class TimeCard < ApplicationRecord
  belongs_to :project
  belongs_to :employee

  validates :clock_in, presence: true
  validates :clock_out, presence: true
  validates :date, presence: true

  def hours_worked
    (clock_out - clock_in) / 3600.00
  end
end
