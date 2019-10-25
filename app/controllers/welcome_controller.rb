class WelcomeController < ApplicationController
  def home
    render json: { info: 'Welcome' }
  end

  def check
    if current_user
      render json: { info: 'authenticated' }, status: :accepted
    else
      render json: { info: 'unauthorized' }, status: :unauthorized
    end
  end
end
