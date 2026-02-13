require 'rails_helper'

RSpec.describe "Vehicles", type: :request do
  describe "POST/create" do
    let(:valid_attributes) do
      {
        year: "1990",
        model: "Chevy 3500HD",
        nick_name: "Red Chevy"
      }
    end

    let(:invalid_attributes) do
      {
        year: "",
        model: "",
        nick_name: 1
      }
    end

    context "with valid attributes" do
      it "creates a new Vehicle" do
        expect {
          post vehicles_path, params: { vehicle: valid_attributes }, headers: headers
        }.to change(Vehicle, :count).by(1)
      end
    end

    context "with invalid attributes" do
      it "it does not create a new Vehicle" do
        expect {
          post vehicles_path, params: { vehicle: invalid_attributes }, headers: headers
        }.not_to change(Vehicle, :count)
      end
    end
  end
end
