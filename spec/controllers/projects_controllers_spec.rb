require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  describe 'PATCH #update' do
    let!(:project) { Project.create!(customer_name: 'Test', address: '12345') }
    let!(:tool) { Tool.create!(name: 'Test', make: 'test', model: 'test') }
    let!(:assigned_tool) { AssignedTool.create!(project: project, tool: tool) } # must exist first

    context 'with valid parameters' do
      let(:valid_params) do
        {
          id: project.id,
          project: {
            assigned_tools_attributes: [
              {
                id: assigned_tool.id,
                hours_onsite: 10.0
              }
            ]
          }
        }
      end
      it 'creates a new tool and the associated AssignedTool with the hours onsite attributes' do
        patch :update, params: valid_params
        expect(assigned_tool.reload.hours_onsite).to eq(10)
      end
    end
  end
end
