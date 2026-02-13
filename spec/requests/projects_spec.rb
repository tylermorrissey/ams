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
        estimates: 1,
        net_cost: 1.0,
        employees: "me",
        materials: "stuff",
        hours_onsite: 1.0,
        equipment_onsite: "truck"
      }
    end

    context "with valid parameters" do
      it "creates a new Project" do
        expect {
          post projects_path, params: { project: valid_attributes }, headers: headers
        }.to change(Project, :count).by(1)
      end
    end
  end
end
