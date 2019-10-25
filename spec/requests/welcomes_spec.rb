# frozen_string_literal: true
require 'rails_helper'

describe WelcomeController, type: :request do
  describe 'GET /' do
    before(:each) do
      get '/'
    end

    it 'returns status 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns an info key with Welcome' do
      expect_json_types(info: :string)
      expect_json(info: 'Welcome')
      expect_json_sizes(1)
    end
  end

  describe 'GET /check' do
    before(:each) do
      user = Fabricate(:user)
      # This will add a valid token for `user` in the `Authorization` header
      @auth_headers = jwt_auth_headers(user)
      user.confirm
    end

    it 'returns http success if token accepted' do
      get '/check', headers: @auth_headers
      expect(response).to have_http_status(:success)
    end

    it 'returns http unauthorized if token modified' do
      changed_header = @auth_headers['Authorization'][0..-2]
      get '/check', headers: default_json_headers.merge("Authorization": changed_header)
      expect(response).to have_http_status(:unauthorized)
    end
  end
end