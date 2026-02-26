require 'rails_helper'

RSpec.describe 'Tools', type: :request do
  describe 'GET /tool' do
    let!(:tool) do
      Tool.create!(name: 'Blower', make: 'Stihl', model: '360', serial_number: '14560',
                   purchase_date: Date.today)
    end
    xit 'responds with a 200 success code' do
      get tool_path

      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /tool' do
    let(:valid_attributes) do
      {
        name: 'Blower',
        make: 'Stihl',
        model: '350',
        serial_number: 45_601,
        purchase_date: Date.today
      }
    end

    let(:invalid_attributes) do
      {
        name: '',
        make: '',
        model: '',
        serial_number: '',
        purchase_date: ''
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
    let!(:tool) do
      Tool.create!(name: 'Blower', make: 'Stihl', model: '360', serial_number: '14560',
                   purchase_date: Date.today)
    end
    xit 'displays the tool name' do
      get edit_tool_path(tool)

      expect(response.body).to include('Blower')
    end
  end

  describe 'GET /tool/:id' do
    let!(:tool) do
      Tool.create!(name: 'Blower', make: 'Stihl', model: '360', serial_number: '14560',
                   purchase_date: Date.today)
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
    let!(:tool) do
      Tool.create!(name: 'Blower', make: 'Stihl', model: '360', serial_number: '14560',
                   purchase_date: Date.today)
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
    let!(:tool) do
      Tool.create!(name: 'Blower', make: 'Stihl', model: '360', serial_number: '14560',
                   purchase_date: Date.today)
    end

    it 'updates all of the tools attributes' do
      put tool_path(tool), params: {
        tool: { name: 'Chainsaw', make: 'Husqvarna', model: '100', serial_number: '24560',
                purchase_date: Date.tomorrow }
      }
      tool.reload
      expect(tool).to have_attributes(name: 'Chainsaw', make: 'Husqvarna', model: '100', serial_number: '24560',
                                      purchase_date: Date.tomorrow)
    end
  end

  describe 'DELETE /tool/:id' do
    let!(:tool) do
      Tool.create!(name: 'Blower', make: 'Stihl', model: '360', serial_number: '14560',
                   purchase_date: Date.today)
    end

    it 'successfully deletes the tool' do
      expect do
        delete tool_path(tool)
      end.to change(Tool, :count).by(-1)
    end
  end
end
