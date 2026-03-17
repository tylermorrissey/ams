require 'rails_helper'
RSpec.describe 'TimeCards', type: :model do
  describe TimeCard do
    describe '#hours_worked' do
      context 'with valid parameters' do
        let!(:timecard) do
          TimeCard.new(clock_in: Time.utc(2026, 8, 1, 14, 35, 0),
                       clock_out: Time.utc(2026, 8, 1, 22, 35, 0))
        end
        it 'successfully returns the correct hours' do
          expect(timecard.hours_worked).to eq(8.00)
        end
      end

      context 'with invalid parameters' do
        let!(:invalid_timecard) do
          TimeCard.new(clock_in: Time.new('', '', '', '', '', ''),
                       clock_out: Time.new('', '', '', '', '', ''))
          it 'fails to calculate' do
            expect { invalid_timecard.hours_worked }.to raise_error(NoMethodError)
          end
        end
      end
    end

    describe 'validations testing' do
      let!(:employee) { Employee.create!(name: 'Test', email: 'test@example.com', role: 'test') }
      let!(:project) { Project.create!(customer_name: 'Test', address: 'Test') }
      it 'is valid with a clock in and clock out' do
        time_card = TimeCard.new(clock_in: Time.current, clock_out: Time.current, date: Date.current, project_id: project.id,
                                 employee_id: employee.id)
        expect(time_card).to be_valid
      end
      it 'is invalid without a clock in time' do
        time_card = TimeCard.new(clock_in: nil, clock_out: Time.current, date: Date.current, project_id: project.id,
                                 employee_id: employee.id)
        expect(time_card).to_not be_valid
      end

      it 'is invalid without a clock out time' do
        time_card = TimeCard.new(clock_in: Time.current, clock_out: nil, date: Date.current, project_id: project.id,
                                 employee_id: employee.id)
        expect(time_card).to_not be_valid
      end

      it 'is invalid without either a clock in or clock out time' do
        time_card = TimeCard.new(clock_in: nil, clock_out: nil, date: Date.current, project_id: project.id,
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
