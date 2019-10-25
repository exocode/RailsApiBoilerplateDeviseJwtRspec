require 'rails_helper'

RSpec.describe Auth::RegistrationsController, type: :controller do
  before(:each) do
    map_devise_user
  end

  context 'POST /auth/signup' do

    context 'without any params' do

      before(:each) { post :create }

      it 'should be an unprocessable entity' do
        expect(response).to have_http_status(:unprocessable_entity)
        expect_status 422
      end

      it 'should not save a user' do
        expect(User.count).to be 0
      end

      it 'returns errors' do
        expect_json_sizes(errors: 2)
        expect_json_keys('errors', [:password, :email])
      end

      it 'describes errors' do
        expect_json_types(info: :string)
        expect_json_sizes('errors.email', 3)
        expect_json_sizes('errors.password', 1)
      end
    end

    context 'with valid params' do

      before(:each) { post :create, params: {user: {email: Faker::Internet.email, password: "password", password_confirmation: "password"}} }

      it 'should be created' do
        expect(response).to have_http_status(:created)
        expect_status 201
      end

      it 'should save a user' do
        expect(User.count).to be 1
      end

      it 'returns no errors' do
        expect_json_sizes(errors: 0)
      end

      it 'returns info' do
        expect_json_types(info: :string)
      end
    end

    context 'with invalid email' do

      before(:each) { post :create, params: {user: {email: "some.email@nodomain", password: "password", password_confirmation: "password"}} }

      it 'should respond with error' do
        expect(response).to have_http_status(:unprocessable_entity)
        expect_status 422
      end

      it 'should not save a user' do
        expect(User.count).to be 0
      end

      it 'returns error' do
        expect_json_sizes(errors: 1)
        expect_json_types(errors: :object)
        expect_json_keys('errors', :email)
      end

      it 'returns user object' do
        expect_json_types(info: :string)
      end
    end

    context 'with invalid password_confirmation' do

      before(:each) { post :create, params: {user: {email: Faker::Internet.email, password: "password", password_confirmation: "wrongpassword"}} }

      it 'should respond with error' do
        expect(response).to have_http_status(:unprocessable_entity)
        expect_status 422
      end

      it 'should not save a user' do
        expect(User.count).to be 0
      end

      it 'returns error' do
        expect_json_sizes(errors: 1)
        expect_json_types(errors: :object)
        expect_json_keys('errors', :password_confirmation)
      end

      it 'returns user object' do
        expect_json_types(info: :string)
      end
    end

    context 'with too short password' do

      before(:each) { post :create, params: {user: {email: Faker::Internet.email, password: "pass", password_confirmation: "pass"}} }

      it 'should respond with error' do
        expect(response).to have_http_status(:unprocessable_entity)
        expect_status 422
      end

      it 'should not save a user' do
        expect(User.count).to be 0
      end

      it 'returns error' do
        puts response.body.inspect
        expect_json_sizes(errors: 1)
        expect_json_types(errors: :object)
        expect_json_keys('errors', :password)
      end

      it 'returns user object' do
        expect_json_types(info: :string)
      end
    end

  end
end
