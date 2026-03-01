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

  describe 'post /assigned_tools' do
    let!(:project) { Project.create(customer_name: 'Test', address: 'Test') }
    let!(:tool) { Tool.create(name: 'Test', make: 'Test', model: 'Test') }
    let(:valid_params) do
      {
        hours_onsite: 6,
        project_id: project.id,
        tool_id: tool.id
      }
    end

    let(:invalid_params) do
      {
        hours_onsite: '',
        project_id: '',
        tool_id: ''
      }
    end
    context 'with valid params' do
      it 'creates an AssignedTool' do
        expect do
          post assigned_tools_path, params: { assigned_tool: valid_params }
        end.to change(AssignedTool, :count).by(1)
      end
      context 'with invalid params' do
        it 'does not create an AssignedTool ' do
          expect do
            post assigned_tools_path, params: { assigned_tool: invalid_params }
          end.to change(AssignedTool, :count).by(0)
        end
      end
    end
  end

  describe 'delete /assigned_tools/:id' do
    let!(:project) { Project.create(customer_name: 'Test', address: 'Test') }
    let!(:tool) { Tool.create(name: 'Test', make: 'Test', model: 'Test') }
    let!(:assigned_tool) do
      AssignedTool.create(hours_onsite: 6,
                          project_id: project.id,
                          tool_id: tool.id)
    end
    it 'deletes the assigned tool' do
      expect do
        delete assigned_tool_path(assigned_tool)
      end.to change(AssignedTool, :count).by(-1)
    end
  end
end
