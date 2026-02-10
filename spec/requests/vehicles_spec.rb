require 'rails_helper'

RSpec.describe "Vehicles", type: :request do
  describe "GET /hello" do
    it "returns http success" do
      get "/vehicles/hello"
      expect(response).to have_http_status(:success)
    end
  end

end
