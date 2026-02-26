class AssignedTool < ApplicationRecord
  belongs_to :project
  belongs_to :tool
end
