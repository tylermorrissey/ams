class TimeCard < ApplicationRecord
  belongs_to :project
  belongs_to :employee
end

def hours_worked(start, finish)
  # do we want to return this as a string or an integer?
  # right now returns as a double
  seconds = finish - start
  seconds / 3600.00
end
