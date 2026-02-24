require 'rails_helper'

RSpec.describe 'TimeCards', type: :request do
  describe 'GET /time_cards' do # index
    let!(:employee) { Employee.create!(name: 'Test', email: 'test@example.com', role: 'test') }
    let!(:project) { Project.create!(customer_name: 'Test') }
    let!(:time_card) do
      TimeCard.create!(clock_in: Time.new(2026, 8, 1, 14, 35, 0), clock_out: Time.new(2026, 8, 1, 14, 35, 0).advance(hours: 8),
                       employee_id: employee.id, project_id: project.id)
    end
    it 'responds with a success code 200' do
      get time_cards_path

      expect(response).to have_http_status(:success)
    end
  end
  describe 'POST /time_cards' do # create
    let!(:employee) { Employee.create!(name: 'Test', email: 'test@example.com', role: 'test') }
    let!(:project) { Project.create!(customer_name: 'Test') }
    let(:valid_attributes) do
      {
        clock_in: Time.new(2026, 8, 1, 14, 35, 0),
        clock_out: Time.new(2026, 8, 1, 14, 35, 0).advance(hours: 8),
        employee_id: employee.id,
        project_id: project.id
      }
    end

    let(:invalid_attributes) do
      {
        clock_in: '',
        clock_out: '',
        employee_id: '',
        project_id: ''
      }
    end

    context 'with valid attributes' do
      it 'successfully creates a Time Card' do
        expect do
          post time_cards_path, params: { time_card: valid_attributes }, headers: headers
        end.to change(TimeCard, :count).by(1)
      end
    end

    context 'with invalid attributes' do
      it 'fails to create a Time Card' do
        expect do
          post time_cards_path, params: { time_card: invalid_attributes }, headers: headers
        end.to change(TimeCard, :count).by(0)
      end
    end
  end
  describe 'GET /time_cards/new' do # new
    let!(:employee) { Employee.create!(name: 'Test', email: 'test@example.com', role: 'test') }
    let!(:project) { Project.create!(customer_name: 'Test') }
    let!(:time_card) do
      TimeCard.create!(clock_in: Time.new(2026, 8, 1, 14, 35, 0), clock_out: Time.new(2026, 8, 1, 14, 35, 0).advance(hours: 8),
                       employee_id: employee.id, project_id: project.id)
    end

    it 'returns a successful response' do
      get time_cards_path(time_card)

      expect(response).to have_http_status(:success)
    end
  end
  describe 'GET /time_cards/:id/edit' do # edit
    let!(:employee) { Employee.create!(name: 'Test', email: 'test@example.com', role: 'test') }
    let!(:project) { Project.create!(customer_name: 'Test') }
    let!(:time_card) do
      TimeCard.create!(clock_in: Time.new(2026, 8, 1, 14, 35, 0), clock_out: Time.new(2026, 8, 1, 14, 35, 0).advance(hours: 8),
                       employee_id: employee.id, project_id: project.id)
    end

    it 'displays the Time Card clock in time' do
      get time_card_path(time_card)

      expect(response.body).to include(project.id.to_s)
    end
  end
  describe 'GET /time_cards/:id' do # show
    let!(:employee) { Employee.create!(name: 'Test', email: 'test@example.com', role: 'test') }
    let!(:project) { Project.create!(customer_name: 'Test') }
    let!(:time_card) do
      TimeCard.create!(clock_in: Time.new(2026, 8, 1, 14, 35, 0).to_s, clock_out: Time.new(2026, 8, 1, 14, 35, 0).advance(hours: 8).to_s,
                       employee_id: employee.id, project_id: project.id)
    end

    it 'returns a successful response' do
      get time_cards_path(time_card)

      expect(response).to have_http_status(:success)
    end

    it 'has the proper fields' do
      get time_cards_path(time_card)

      expect(response.body).to include(Time.new(2026, 8, 1, 14, 35, 0).to_s, Time.new(2026, 8, 1, 14, 35, 0).advance(hours: 8).to_s, project.id,
                                       employee.id)
    end
  end
  describe 'PATCH /time_cards/:id' do # update
    let!(:employee) { Employee.create!(name: 'Test', email: 'test@example.com', role: 'test') }
    let!(:project) { Project.create!(customer_name: 'Test') }
    let!(:time_card) do
      TimeCard.create!(clock_in: Time.new(2026, 8, 1, 14, 35, 0), clock_out: Time.new(2026, 8, 1, 14, 35, 0).advance(hours: 8),
                       employee_id: employee.id, project_id: project.id)
    end
    it 'successfully updates the clock in' do
      new_time = Time.new(2026, 9, 1, 14, 35, 0)
      puts new_time
      patch time_card_path(time_card), params: {
        time_card: { clock_in: new_time }
      }
      time_card.reload
      puts time_card.errors.full_messages
      expect(time_card.clock_in).to eq(new_time)
    end
  end
  describe 'PUT /time_cards/:id' do # update
    let!(:employee) { Employee.create!(name: 'Test', email: 'test@example.com', role: 'test') }
    let!(:project) { Project.create!(customer_name: 'Test') }
    let!(:time_card) do
      TimeCard.create!(clock_in: Time.new(2026, 8, 1, 14, 35, 0), clock_out: Time.new(2026, 8, 1, 14, 35, 0).advance(hours: 8),
                       employee_id: employee.id, project_id: project.id)
    end
    it 'successfully updates the Time Card' do
      new_clock_in = 1.hour.from_now
      new_clock_out = 1.hour.from_now
      put time_card_path(time_card), params: {
        time_card: { clock_in: new_clock_in.to_i, clock_out: new_clock_out.to_i }
      }
      time_card.reload
      expect(time_card).to have_attributes(clock_in: new_clock_in.to_i, clock_out: new_clock_out.to_i, employee_id: employee.id,
                                           project_id: project.id)
    end
  end
  describe 'DELETE /time_cards/:id' do # destroy
    let!(:employee) { Employee.create!(name: 'Test', email: 'test@example.com', role: 'test') }
    let!(:project) { Project.create!(customer_name: 'Test') }
    let!(:time_card) do
      TimeCard.create!(clock_in: Time.new(2026, 8, 1, 14, 35, 0), clock_out: Time.new(2026, 8, 1, 14, 35, 0).advance(hours: 8),
                       employee_id: employee.id, project_id: project.id)
    end

    it 'successfully deletes the Time Card' do
      expect do
        delete time_card_path(time_card).to change(TimeCard, :count).by(-1)
      end
    end
  end
end

RSpec.describe 'TimeCards', type: :model do
  describe '#hours_worked' do
    context 'with valid parameters' do
      let!(:start) { Time.new(2026, 8, 1, 14, 35, 0) }
      let!(:finish) { Time.new(2026, 8, 1, 14, 35, 0).advance(hours: 8) }
      it 'successfully returns the correct hours' do
        expect(hours_worked(start, finish)).to eq(8.00)
      end
    end

    context 'with invalid parameters' do
      it 'fails to calculate' do
        expect { hours_worked('', '') }.to raise_error(NoMethodError)
      end
    end
  end

  describe 'validations testing' do
    let!(:employee) { Employee.create!(name: 'Test', email: 'test@example.com', role: 'test') }
    let!(:project) { Project.create!(customer_name: 'Test') }
    it 'is valid with a clock in and clock out' do
      time_card = TimeCard.new(clock_in: Time.now, clock_out: Time.now, project_id: project.id,
                               employee_id: employee.id)
      expect(time_card).to be_valid
    end
    it 'is invalid without a clock in time' do
      time_card = TimeCard.new(clock_in: nil, clock_out: Time.now, project_id: project.id,
                               employee_id: employee.id)
      expect(time_card).to_not be_valid
    end

    it 'is invalid without a clock out time' do
      time_card = TimeCard.new(clock_in: Time.now, clock_out: nil, project_id: project.id,
                               employee_id: employee.id)
      expect(time_card).to_not be_valid
    end

    it 'is invalid without either a clock in or clock out time' do
      time_card = TimeCard.new(clock_in: nil, clock_out: nil, project_id: project.id,
                               employee_id: employee.id)
      expect(time_card).to_not be_valid
    end
  end
end
