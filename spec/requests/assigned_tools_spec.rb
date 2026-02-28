require 'rails_helper'

RSpec.describe 'AssignedTools', type: :request do
  describe 'assigning and unassigning tools to projects' do
    let!(:project1) { Project.create!(customer_name: 'Test Project', address: 'Test') }
    let!(:project2) { Project.create!(customer_name: 'Test Project', address: 'Test') }
    let!(:tool) do
      Tool.create!(name: 'Blower', make: 'Stihl', model: '360', serial_number: '14560',
                   purchase_date: Date.today)
    end

    let!(:assigned_tool) { AssignedTool.create!(project_id: project1.id, tool_id: tool.id, hours_onsite: 5) }
    it 'successfully assigns to another project' do
      patch assigned_tool_path(assigned_tool), params: {
        assigned_tool: {
          project_id: project2.id
        }
      }
      assigned_tool.reload
      expect(assigned_tool.project_id).to eq(project2.id)
    end
  end
end
