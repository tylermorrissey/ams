require 'rails_helper'

RSpec.describe 'Tools', type: :request do
  describe 'GET /tool' do
    let!(:project) { Project.create!(customer_name: 'Test Project', address: 'Test') }
    let!(:tool) do
      Tool.create!(name: 'Blower', make: 'Stihl', model: '360', serial_number: '14560',
                   purchase_date: Date.today, project_id: project.id)
    end
    xit 'responds with a 200 success code' do
      get tool_path

      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /tool' do
    let!(:project) { Project.create!(customer_name: 'Test Project', address: 'Test') }
    let(:valid_attributes) do
      {
        name: 'Blower',
        make: 'Stihl',
        model: '350',
        serial_number: 45_601,
        purchase_date: Date.today,
        project_id: project.id
      }
    end

    let(:invalid_attributes) do
      {
        name: '',
        make: '',
        model: '',
        serial_number: '',
        purchase_date: '',
        project_id: ''
      }
    end

    context 'with valid parameters' do
      it 'creates a new Tool' do
        expect do
          post tools_path, params: { tool: valid_attributes }, headers: headers
        end.to change(Tool, :count).by(1)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Tool' do
        expect do
          post tools_path, params: { tool: invalid_attributes }, headers: headers
        end.to change(Tool, :count).by(0)
      end
    end
  end

  describe 'GET /tool/new' do
    xit 'returns a successful response' do
      get new_tool_path

      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /tool/:id/edit' do
    let!(:project) { Project.create!(customer_name: 'Test Project', address: 'Test') }
    let!(:tool) do
      Tool.create!(name: 'Blower', make: 'Stihl', model: '360', serial_number: '14560',
                   purchase_date: Date.today, project_id: project.id)
    end
    xit 'displays the tool name' do
      get edit_tool_path(tool)

      expect(response.body).to include('Blower')
    end
  end

  describe 'GET /tool/:id' do
    let!(:project) { Project.create!(customer_name: 'Test Project', address: 'Test') }

    let!(:tool) do
      Tool.create!(name: 'Blower', make: 'Stihl', model: '360', serial_number: '14560',
                   purchase_date: Date.today, project_id: project.id)
    end
    xit 'returns a successful response' do
      get tool_path(tool)

      expect(response).to have_http_status(:success)
    end

    xit 'displays the proper fields' do
      get tool_path(tool)

      expect(response.body).to include('Blower', 'Stihl', '360', '14560', Date.today.to_s)
    end
  end

  describe 'PATCH /tool/:id' do
    let!(:project) { Project.create!(customer_name: 'Test Project', address: 'Test') }

    let!(:tool) do
      Tool.create!(name: 'Blower', make: 'Stihl', model: '360', serial_number: '14560',
                   purchase_date: Date.today, project_id: project.id)
    end
    it 'updates the name of the tool' do
      patch tool_path(tool), params: {
        tool: { name: 'Chainsaw' }
      }
      tool.reload
      expect(tool.name).to eq('Chainsaw')
    end
  end

  describe 'PUT /tool/:id' do
    let!(:project) { Project.create!(customer_name: 'Test Project', address: 'Test') }
    let!(:tool) do
      Tool.create!(name: 'Blower', make: 'Stihl', model: '360', serial_number: '14560',
                   purchase_date: Date.today, project_id: project.id)
    end

    it 'updates all of the tools attributes' do
      put tool_path(tool), params: {
        tool: { name: 'Chainsaw', make: 'Husqvarna', model: '100', serial_number: '24560',
                purchase_date: Date.tomorrow, project_id: project.id }
      }
      tool.reload
      expect(tool).to have_attributes(name: 'Chainsaw', make: 'Husqvarna', model: '100', serial_number: '24560',
                                      purchase_date: Date.tomorrow, project_id: project.id)
    end
  end

  describe 'DELETE /tool/:id' do
    let!(:project) { Project.create!(customer_name: 'Test Project', address: 'Test') }

    let!(:tool) do
      Tool.create!(name: 'Blower', make: 'Stihl', model: '360', serial_number: '14560',
                   purchase_date: Date.today, project_id: project.id)
    end
    it 'successfully deletes the tool' do
      expect do
        delete tool_path(tool).to change(Tool, :count).by(-1)
      end
    end
  end

  describe 'assigning and unassigning tools to projects' do
    let!(:project1) { Project.create!(customer_name: 'Test Project', address: 'Test') }
    let!(:project2) { Project.create!(customer_name: 'Test Project', address: 'Test') }
    let!(:tool) do
      Tool.create!(name: 'Blower', make: 'Stihl', model: '360', serial_number: '14560',
                   purchase_date: Date.today, project_id: project1.id)
    end
    it 'successfully assigns to another project' do
      patch tool_path(tool), params: {
        tool: { project_id: project2.id }
      }
      tool.reload
      expect(tool.project_id).to eq(project2.id)
    end
  end
end
