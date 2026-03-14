class TimeCard < ApplicationRecord
  belongs_to :project
  belongs_to :employee

  validates :clock_in, presence: true
  validates :clock_out, presence: true
end

def hours_worked(start, finish)
  seconds = finish - start
  seconds / 3600.00
end
