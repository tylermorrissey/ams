require 'rails_helper'

RSpec.describe "Employees", type: :request do
  # Set a modern browser user agent for all requests to bypass allow_browser check
  let(:headers) do
    { "HTTP_USER_AGENT" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36" }
  end

  describe "POST /projects" do
     let(:valid_attributes) do
      {
        customer_name: "John Doe"
        # date: Date.new(2024, 1, 15),
        # address: "123 Main St, Columbus, OH",
        # desc: "Install a retaining wall and cut down a tree",
        # job_type: "retaining wall",
        # estimates: 8500,
        # net_cost: 7925.50,
        # employees: "Mike, Sarah, Alex",
        # materials: "Concrete blocks, gravel, preen, fertilizer, gas",
        # hours_onsite: 42.5,
        # equipment_onsite: "Loader, truck, excavator"
      }
    end
    context "with valid parameters" do
      it "creates a valid Project" do
        post projects_path, params: { project: valid_attributes }, headers: headers

        puts response.status
        puts Project.last&.errors&.full_messages

        expect(Project.count).to eq(1)
        # expect {
        # post projects_path, params: valid_attributes, headers: headers
        # }.to change(Project, :count).by(1)
      end
    end
  end
end