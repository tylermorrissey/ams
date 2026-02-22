class TimeCard < ApplicationRecord
  belongs_to :project
  belongs_to :employee
end

def hours_worked(start, finish)
  #do we want to return this as a string or an integer?
  seconds = finish - start
  hours = seconds / 3600.0
  return hours
end

def test
  start = Time.new(2015, 8, 1, 14, 35, 0)
  finish = Time.new(2015, 8, 1, 14, 35, 0).advance(hours: 5)
  puts hours_worked(start, finish)
end

