require 'rails_helper'

RSpec.describe "S3Files", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/s3_files/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/s3_files/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/s3_files/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/s3_files/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
