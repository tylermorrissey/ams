require 'rails_helper'

RSpec.describe 'AssignedTools', type: :model do
  describe AssignedTool do
    let(:tool) do
      Tool.create!(name: 'Chainsaw', make: 'Stihl', model: '690', serial_number: '12345', purchase_date: Date.today)
    end

    let!(:employee) { Employee.create!(name: 'test', email: 'test@example.com', role: 'test') }

    let!(:project) do
      Project.create!(customer_name: 'Acme Construction LLC',
                      address: '1234 Industrial Way, Columbus, OH 43215',
                      desc: 'Commercial HVAC installation for new office build-out',
                      job_type: 'Commercial Installation',
                      estimates: 18_500.75,
                      net_cost: 17_240.50,
                      employee_ids: [employee.id],
                      materials: 'Ductwork, rooftop unit, thermostats, copper piping',
                      hours_onsite: 64.5,
                      equipment_onsite: 'Scissor lift, welding kit, HVAC vacuum pump',
                      date_started: Date.new(2026, 7, 1),
                      date_ended: Date.new(2026, 7, 10))
    end

    it 'should belong to Tool' do
      t = AssignedTool.reflect_on_association(:tool)
      expect(t.macro).to eq(:belongs_to)
    end

    it 'should belong to Project' do
      t = AssignedTool.reflect_on_association(:project)
      expect(t.macro).to eq(:belongs_to)
    end

    it 'should assign Tools to Projects' do
      project.tools << tool
      expect(AssignedTool.count).to eq(1)
      expect(AssignedTool.first.project_id).to eq(project.id)
      expect(AssignedTool.first.tool_id).to eq(tool.id)
    end
  end
end
