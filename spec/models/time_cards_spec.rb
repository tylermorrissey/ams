require 'rails_helper'
RSpec.describe 'TimeCards', type: :model do
  describe TimeCard do
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
      let!(:project) { Project.create!(customer_name: 'Test', address: 'Test') }
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

    describe 'associations testing' do
      let!(:employee) { Employee.create!(name: 'Test', email: 'test@example.com', role: 'test') }
      let!(:project) { Project.create!(customer_name: 'Test', address: 'Test') }
      it 'should belong to Employee' do
        t = TimeCard.reflect_on_association(:employee)
        expect(t.macro).to eq(:belongs_to)
      end

      it 'should belong to Project' do
        t = TimeCard.reflect_on_association(:project)
        expect(t.macro).to eq(:belongs_to)
      end
    end
  end
end
