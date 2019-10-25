require 'rails_helper'

describe 'POST /auth/sign_in', type: :request do
  let(:user) { Fabricate(:user) }
  let(:url) { '/auth/sign_in' }
  let(:params) do
    { user: { email: user.email,
              password: user.password } }
  end

  context 'when headers are correct' do
    before(:each) do
      default_json_headers
      # This will add a valid token for `user` in the `Authorization` header
      user.confirm
      post url, headers: jwt_auth_headers(user)
    end

    it 'returns ok status' do
      expect(response).to have_http_status(:created)
      expect(response).to have_http_status(201)
    end

    it 'returns JTW token in authorization header' do
      expect(response.header['Authorization']).to be_present
      expect(response.header['Authorization'].split(' ').first).to eq 'Bearer'
    end

    it 'returns valid JWT token' do
      decoded_token = decoded_jwt_token(response)
      expect(decoded_token.first['sub']).to be_present
    end
  end

  context 'when no params are given' do
    before { post url, params: {}, headers: default_json_headers }

    it 'returns unauthorized status' do
      expect(response).to have_http_status(:unauthorized)
      expect(response).to have_http_status(401)
    end

  end
end

describe 'DELETE /logout', type: :request do
  let(:url) { '/auth/sign_out' }

  it 'returns 204, no content' do
    delete url
    expect(response).to have_http_status(204)
  end
end