require 'rails_helper'

RSpec.describe "Assignments", type: :request do
  let(:headers) do
    { "HTTP_USER_AGENT" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36" }
  end    
  
  describe "POST /assignments" do

    let!(:employee) { Employee.create!(name: "Wes") }
    let!(:project)  { Project.create!(name: "Dig") }

    let(:valid_attributes) do
    {
      employee_id: employee.id,
      project_id: project.id,
      hours_onsite: 40
    }
    end

    let(:invalid_attributes) do
    {
      employee_id: 2.0,
      project_id: 2.0,
      hours_onsite: "hotdog"
    }
    end

    context "with valid parameters"
      it "creates an assignment between the employee and the project" do
        expect {
        post assignments_path, params: { assignment: valid_attributes }, headers: headers
      }.to change(Assignment, :count).by(1)
    end

    context "with invalid parameters"
      it " does not create an assignment between the employee and the project" do
        expect {
        post assignments_path, params: { assignment: invalid_attributes }, headers: headers
      }.not_to change(Assignment, :count)
    end
  end
end
