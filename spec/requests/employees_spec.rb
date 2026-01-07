require 'rails_helper'

RSpec.describe "Employees", type: :request do
  # Set a modern browser user agent for all requests to bypass allow_browser check
  let(:headers) do
    { "HTTP_USER_AGENT" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36" }
  end

  describe "POST /employees" do
    let(:valid_attributes) do
      {
        name: "John Doe",
        email: "john.doe@example.com",
        phone: "555-1234",
        role: "Developer",
        hire_date: "2024-01-15"
      }
    end

    let(:invalid_attributes) do
      {
        name: "",
        email: "invalid_email",
        role: ""
      }
    end

    context "with valid parameters" do
      it "creates a new Employee" do
        expect {
          post employees_path, params: { employee: valid_attributes }, headers: headers
        }.to change(Employee, :count).by(1)
      end

      it "redirects to the created employee" do
        post employees_path, params: { employee: valid_attributes }, headers: headers
        expect(response).to redirect_to(employee_path(Employee.last))
      end

      it "sets a success notice" do
        post employees_path, params: { employee: valid_attributes }, headers: headers
        follow_redirect!
        expect(response.body).to include("Employee was successfully created.")
      end

      it "returns a redirect status (302)" do
        post employees_path, params: { employee: valid_attributes }, headers: headers
        expect(response).to have_http_status(:found)
      end
    end

    context "with invalid parameters" do
      it "does not create a new Employee" do
        expect {
          post employees_path, params: { employee: invalid_attributes }, headers: headers
        }.not_to change(Employee, :count)
      end

      it "renders the new template" do
        post employees_path, params: { employee: invalid_attributes }, headers: headers
        expect(response).to render_template(:new)
      end

      it "returns unprocessable entity status (422)" do
        post employees_path, params: { employee: invalid_attributes }, headers: headers
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "displays validation errors" do
        post employees_path, params: { employee: invalid_attributes }, headers: headers
        expect(response.body).to include("can&#39;t be blank")
      end
    end

    context "with missing parameters" do
      it "returns bad request status when employee param is missing" do
        post employees_path, params: { name: "John Doe", email: "test@example.com" }, headers: headers
        expect(response).to have_http_status(:bad_request)
      end

      it "returns bad request status with empty params" do
        post employees_path, params: {}, headers: headers
        expect(response).to have_http_status(:bad_request)
      end
    end

    context "with unpermitted parameters" do
      let(:unpermitted_attributes) do
        {
          name: "Jane Smith",
          email: "jane.smith@example.com",
          role: "Designer",
          unauthorized_field: "should not be saved",
          admin: true
        }
      end

      it "filters unpermitted parameters" do
        post employees_path, params: { employee: unpermitted_attributes }, headers: headers
        created_employee = Employee.last
        
        # Verify permitted parameters are saved
        expect(created_employee.name).to eq("Jane Smith")
        expect(created_employee.email).to eq("jane.smith@example.com")
        expect(created_employee.role).to eq("Designer")
        
        # Verify unpermitted parameters are not saved (employee should not have these attributes)
        expect(created_employee).not_to respond_to(:unauthorized_field)
        expect(created_employee).not_to respond_to(:admin)
      end

      it "creates an employee successfully despite unpermitted params" do
        expect {
          post employees_path, params: { employee: unpermitted_attributes }, headers: headers
        }.to change(Employee, :count).by(1)
      end
    end
  end
end
