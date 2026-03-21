require 'rails_helper'

RSpec.describe 'TimeCards', type: :request do
  describe 'GET /time_cards' do # index
    let!(:employee) { Employee.create!(name: 'Test', email: 'test@example.com', role: 'test') }
    let!(:project) { Project.create!(customer_name: 'Test', address: 'Test') }
    let!(:time_card) do
      TimeCard.create!(clock_in: Time.utc(2026, 8, 1, 14, 35, 0),
                       clock_out: Time.utc(2026, 8, 1, 14, 35, 0).advance(hours: 8),
                       date: Date.current,
                       employee_id: employee.id,
                       project_id: project.id)
    end
    xit 'responds with a success code 200' do
      get time_cards_path

      expect(response).to have_http_status(:success)
    end
  end
  describe 'POST /time_cards' do # create
    let!(:employee) { Employee.create!(name: 'Test', email: 'test@example.com', role: 'test') }
    let!(:project) { Project.create!(customer_name: 'Test', address: 'Test') }
    let(:valid_attributes) do
      {
        clock_in: Time.utc(2026, 8, 1, 14, 35, 0),
        clock_out: Time.utc(2026, 8, 1, 14, 35, 0).advance(hours: 8),
        date: Date.current,
        employee_id: employee.id,
        project_id: project.id
      }
    end

    let(:invalid_attributes) do
      {
        clock_in: '',
        clock_out: '',
        date: '',
        employee_id: '',
        project_id: ''
      }
    end

    context 'with valid attributes' do
      it 'successfully creates a Time Card' do
        expect do
          post time_cards_path, params: { time_card: valid_attributes }
        end.to change(TimeCard, :count).by(1)
      end
    end

    context 'with invalid attributes' do
      it 'fails to create a Time Card' do
        expect do
          post time_cards_path, params: { time_card: invalid_attributes }
        end.to change(TimeCard, :count).by(0)
      end
    end
  end
  describe 'GET /time_cards/new' do # new
    let!(:employee) { Employee.create!(name: 'Test', email: 'test@example.com', role: 'test') }
    let!(:project) { Project.create!(customer_name: 'Test', address: 'Test') }
    let!(:time_card) do
      TimeCard.create!(clock_in: Time.utc(2026, 8, 1, 14, 35, 0),
                       clock_out: Time.utc(2026, 8, 1, 14, 35, 0).advance(hours: 8),
                       date: Date.current,
                       employee_id: employee.id,
                       project_id: project.id)
    end

    xit 'returns a successful response' do
      get new_time_card_path

      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /time_cards/:id/edit' do # edit
    let!(:employee) { Employee.create!(name: 'Test', email: 'test@example.com', role: 'test') }
    let!(:project) { Project.create!(customer_name: 'Test', address: 'Test') }
    let!(:time_card) do
      TimeCard.create!(clock_in: Time.utc(2026, 8, 1, 14, 35, 0),
                       clock_out: Time.utc(2026, 8, 1, 14, 35, 0).advance(hours: 8),
                       date: Date.current,
                       employee_id: employee.id,
                       project_id: project.id)
    end

    xit 'displays the Time Card clock in time' do
      get time_card_path(time_card)

      expect(response.body).to include(project.id.to_s)
    end
  end

  describe 'GET /time_cards/:id' do # show
    let!(:employee) { Employee.create!(name: 'Test', email: 'test@example.com', role: 'test') }
    let!(:project) { Project.create!(customer_name: 'Test', address: 'Test') }
    let!(:time_card) do
      TimeCard.create!(clock_in: Time.utc(2026, 8, 1, 14, 35, 0),
                       clock_out: Time.utc(2026, 8, 1, 14, 35, 0).advance(hours: 8),
                       date: Date.current,
                       employee_id: employee.id,
                       project_id: project.id)
    end

    xit 'returns a successful response' do
      get time_card_path(time_card)

      expect(response).to have_http_status(:success)
    end

    xit 'has the proper fields' do
      get time_card_path(time_card)

      expect(response.body).to include(Time.new(2026, 8, 1, 14, 35, 0).to_s,
                                       Time.new(2026, 8, 1, 14, 35, 0).advance(hours: 8).to_s,
                                       project.id.to_s,
                                       employee.id.to_s)
    end
  end
  describe 'PATCH /time_cards/:id' do # update
    let!(:employee) { Employee.create!(name: 'Test', email: 'test@example.com', role: 'test') }
    let!(:project) { Project.create!(customer_name: 'Test', address: 'Test') }
    let!(:time_card) do
      TimeCard.create!(clock_in: Time.new(2026, 8, 1, 14, 35, 0),
                       clock_out: Time.new(2026, 8, 1, 14, 35, 0).advance(hours: 8),
                       date: Date.current,
                       employee_id: employee.id,
                       project_id: project.id)
    end
    it 'successfully updates the employee' do
      new_employee = Employee.create!(name: 'Test1', email: 'test1@example.com', role: 'test1')
      patch time_card_path(time_card), params: {
        time_card: { employee_id: new_employee.id }
      }
      time_card.reload
      expect(time_card.employee_id).to eq(new_employee.id)
    end
  end
  describe 'PUT /time_cards/:id' do # update
    let!(:employee) { Employee.create!(name: 'Test', email: 'test@example.com', role: 'test') }
    let!(:project) { Project.create!(customer_name: 'Test', address: 'Test') }
    let!(:time_card) do
      TimeCard.create!(clock_in: Time.utc(2026, 8, 1, 14, 35, 0),
                       clock_out: Time.utc(2026, 8, 1, 14, 35, 0).advance(hours: 8),
                       date: Date.current,
                       employee_id: employee.id,
                       project_id: project.id)
    end
    it 'successfully updates the Time Card' do
      new_clock_in = Time.utc(2026, 8, 1, 14, 35, 0).advance(hours: 1)
      new_clock_out = Time.utc(2026, 8, 1, 14, 35, 0).advance(hours: 9)
      new_date = Date.tomorrow
      put time_card_path(time_card), params: {
        time_card: { clock_in: new_clock_in,
                     clock_out: new_clock_out,
                     date: new_date,
                     employee_id: employee.id,
                     project_id: project.id }
      }
      time_card.reload
      expect(time_card).to have_attributes(clock_in: new_clock_in, clock_out: new_clock_out, employee_id: employee.id,
                                           project_id: project.id)
    end
  end
  describe 'DELETE /time_cards/:id' do # destroy
    let!(:employee) { Employee.create!(name: 'Test', email: 'test@example.com', role: 'test') }
    let!(:project) { Project.create!(customer_name: 'Test', address: 'Test') }
    let!(:time_card) do
      TimeCard.create!(clock_in: Time.new(2026, 8, 1, 14, 35, 0),
                       clock_out: Time.new(2026, 8, 1, 14, 35, 0).advance(hours: 8),
                       date: Date.current,
                       employee_id: employee.id,
                       project_id: project.id)
    end

    it 'successfully deletes the Time Card' do
      expect do
        delete time_card_path(time_card)
      end.to change(TimeCard, :count).by(-1)
    end
  end
end
