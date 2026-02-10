class ProjectVehicle < ApplicationRecord
  belongs_to :vehicle
  belongs_to :project
end
