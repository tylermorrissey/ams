require 'rails_helper'

RSpec.describe "Projects", type: :request do
  describe "POST /create" do
    let(:valid_attributes) do
      {
        customer_name: "Test",
        date: Date.today,
        address: "123",
        desc: "Test",
        job_type: "test",
        estimates: 1.0,
        net_cost: 1.0,
        employees: [1],
        materials: "stuff",
        hours_onsite: 1.0,
        equipment_onsite: "truck",
        date_started: Date.today,
        date_ended: Date.tomorrow
      }
    end

    let(:invalid_attributes) do
      {
        customer_name: 2900,
        date: Date.today,
        address: 123,
        desc: 123,
        job_type: 12.0,
        estimates: "invalid",
        net_cost: 1.0,
        employees: "me",
        materials: "stuff",
        hours_onsite: 1.0,
        equipment_onsite: "truck"
      }
    end

    context "with valid parameters" do
      it "creates a new Project" do
      xit "creates a new Project" do
        expect {
          post projects_path, params: { project: valid_attributes }, headers: headers
        }.to change(Project, :count).by(1)
      end
    end

    context "with invalid parameters" do
      xit "fails to create a new Project" do
        expect {
          post projects_path, params: { project: invalid_attributes }, headers: headers
        }.to change(Project, :count).by(0)
      end
    end
  end

  describe "GET /projects" do
    xit "returns a status code 200 (OK)" do
      get "/projects"
      expect(response).to have_http_success(:success)    
    end
  end

  describe "GET /projects/:id" do
    xit "returns a specific project" do
    project = Project.create(
        customer_name: "Test",
        date: Date.today,
        address: "12345",
        desc: "Test",
        job_type: "Test",
        estimates: 1,
        net_cost: 1.0,
        employees: "Test",
        materials: "Test",
        hours_onsite: 1.0,
        equipment_onsite: "Test")
        
      get "/projects/#{project.id}"
      expect(respone).to have_http_success(:success)

      #put this in Model :show. render json: @project
      # json = JSON.parse(response.body)
      # expect(json["customer_name"]).to eq("Test")
    end
  end
  describe "GET /projects/invalid_id" do
    xit "fails to return a specific project" do
      invalid_id = "hotdog"
      get "/projects/#{invalid_id}"
      expect(respones).not_to be_successful
    end
  end
end
end
