require 'rails_helper'

describe WelcomeController, type: :controller do

  describe 'GET #home' do
    it 'returns http success' do
      get :home
      expect(response).to have_http_status(:success)
    end
  end

end
