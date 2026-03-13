class AssignedTool < ApplicationRecord
  belongs_to :project
  belongs_to :tool

  validates :project_id, presence: true
  validates :tool_id, presence: true
end
