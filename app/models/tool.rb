class Tool < ApplicationRecord
  has_many :project, dependent: :destroy
end
