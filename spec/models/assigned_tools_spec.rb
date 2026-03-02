require 'rails_helper'

RSpec.describe 'AssignedTools', type: :model do
  describe AssignedTool do
    it 'should belong to Tool' do
      t = AssignedTool.reflect_on_association(:tool)
      expect(t.macro).to eq(:belongs_to)
    end

    it 'should belong to Project' do
      t = AssignedTool.reflect_on_association(:project)
      expect(t.macro).to eq(:belongs_to)
    end
  end
end
