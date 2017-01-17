require 'rails_helper'

RSpec.describe "Images API", type: :request do
  describe "POST /api/v1/images" do
    let(:file) { Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, 'spec/support/images/image.jpg'))) }
    let_auth_headers

    it "uploads an image and returns url for uploaded file" do
      post '/api/v1/images', params: {file: file}, headers: auth_headers

      expect(response).to have_http_status(200)
      expect(json['url']).not_to be_nil
    end
  end
end
