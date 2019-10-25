require 'rails_helper'

module JwtMacros
  # @param [Object] response
  def decoded_jwt_token(response)
    token_from_request = response.headers['Authorization'].split(' ').last
    JWT.decode(token_from_request, ENV['DEVISE_JWT_SECRET_KEY'], true)
  end

  def default_json_headers
    { 'Accept' => 'application/json',
      'Content-Type' => 'application/json' }
  end

  # @param [User] user
  def jwt_auth_headers(user)
    Devise::JWT::TestHelpers.auth_headers(default_json_headers, user)
  end
end
