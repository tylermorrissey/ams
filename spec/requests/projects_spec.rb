require 'rails_helper'

RSpec.describe 'Projects', type: :request do
  describe 'GET /projects' do # index
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
    it 'responds with a success code 200' do
      get projects_path

      expect(response).to have_http_status(:success)
    end
  end
  describe 'POST /projects' do # create
    let!(:employee) { Employee.create!(name: 'Test', email: 'test@example.com', role: 'test') }
    let(:valid_attributes) do
      {
        customer_name: 'Acme Construction LLC',
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
        date_ended: Date.new(2026, 7, 10)
      }
    end

    let(:invalid_attributes) do
      {
        customer_name: '',
        address: '',
        desc: '',
        job_type: '',
        estimates: '',
        net_cost: '',
        employees: '',
        materials: '',
        hours_onsite: '',
        equipment_onsite: '',
        date_started: '',
        date_ended: ''
      }
    end
    context 'with valid parameters' do
      it 'successfully creates a project' do
        expect do
          post projects_path, params: { project: valid_attributes }, headers: headers
        end.to change(Project, :count).by(1)
      end
    end

    context 'with invalid parameters' do
      it 'fails to create a project' do
        expect do
          post projects_path, params: { project: invalid_attributes }, headers: headers
        end.to change(Project, :count).by(0)
      end
    end
  end

  describe 'GET /projects/new' do # new
    let!(:employee) { Employee.create!(name: 'Test', email: 'test@example.com', role: 'test') }
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

    it 'returns a successful response' do
      get projects_path(project)

      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /projects/:id/edit' do # edit
    let!(:employee) { Employee.create!(name: 'Test', email: 'test@example.com', role: 'test') }
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

    it 'displays the customer name of the project' do
      get project_path(project)

      expect(response.body).to include('Acme Construction LLC')
    end
  end

  describe 'GET /projects/:id' do # show
    let!(:employee) { Employee.create!(name: 'Test', email: 'test@example.com', role: 'test') }
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

    it 'returns a success response' do
      get project_path(project)

      expect(response).to have_http_status(:success)
    end
    it 'has the proper fields' do
      get project_path(project)

      expect(response.body).to include('Acme Construction LLC',
                                       '1234 Industrial Way, Columbus, OH 43215',
                                       'Commercial HVAC installation for new office build-out',
                                       'Commercial Installation',
                                       18_500.75.to_s,
                                       17_240.50.to_s,
                                       64.5.to_s,
                                       'Scissor lift, welding kit, HVAC vacuum pump',
                                       Date.new(2026, 7, 1).to_s,
                                       Date.new(2026, 7, 10).to_s)
    end
  end
  describe 'PATCH /projects/:id' do # update
    let!(:employee) { Employee.create!(name: 'Test', email: 'test@example.com', role: 'test') }
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
    it 'successfully updates the customer name' do
      patch project_path(project), params: {
        project: { customer_name: 'Fudd' }
      }
      project.reload
      expect(project.customer_name).to eq('Fudd')
    end
  end

  describe 'PUT /projects/:id' do # update
    let!(:employee) { Employee.create!(name: 'Test', email: 'test@example.com', role: 'test') }
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
    it 'successfully updates the customer name' do
      put project_path(project), params: {
        project: { customer_name: 'Bugs Bunny',
                   address: '1 Carrot Patch Lane, Looneyville, CA 90210',
                   desc: 'Underground tunnel expansion with reinforced carrot storage vault',
                   job_type: 'Custom Burrow Construction',
                   estimates: 75_000.00,
                   net_cost: 68_450.25,
                   employee_ids: [employee.id],
                   materials: 'Reinforced concrete, steel supports, ventilation shafts, premium carrot insulation',
                   hours_onsite: 210.5,
                   equipment_onsite: 'Industrial drill rig, tunnel boring machine, carrot preservation unit',
                   date_started: Date.new(2026, 4, 1),
                   date_ended: Date.new(2026, 5, 15) }
      }
      project.reload
      expect(project).to have_attributes(customer_name: 'Bugs Bunny',
                                         address: '1 Carrot Patch Lane, Looneyville, CA 90210',
                                         desc: 'Underground tunnel expansion with reinforced carrot storage vault',
                                         job_type: 'Custom Burrow Construction',
                                         estimates: 75_000.00,
                                         net_cost: 68_450.25,
                                         employee_ids: [employee.id],
                                         materials: 'Reinforced concrete, steel supports, ventilation shafts, premium carrot insulation',
                                         hours_onsite: 210.5,
                                         equipment_onsite: 'Industrial drill rig, tunnel boring machine, carrot preservation unit',
                                         date_started: Date.new(2026, 4, 1),
                                         date_ended: Date.new(2026, 5, 15))
    end
  end

  describe 'DELETE /projects/:id' do # destroy
    let!(:employee) { Employee.create!(name: 'Test', email: 'test@example.com', role: 'test') }
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

    it 'successfully deletes the Project' do
      expect do
        delete project_path(project).to change(Project, :count).by(-1)
      end
    end
  end
end
