module DeviseMacros

  # map_devise_user, map_devise_admin is usually used in ControllerTests to tell
  # devise which controller scope should be used
  # (you can have more than one e.g. :admin, :premium)
  # use this if you don't sign in any user, but need basic devise functionality

  def map_devise_user
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  def map_devise_admin
    @request.env['devise.mapping'] = Devise.mappings[:admin]
  end

end


module DeviseControllerMacros

  def setup
    @request.env["devise.mapping"] = Devise.mappings[:administrator]
    sign_in FactoryBot.create(:admin)
  end

  def login_admin
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:administrator]

      @user = Fabricate(:admin)
      @user.confirm
      sign_in @user
      @current_user ||= @user
    end
  end

  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @user = Fabricate(:user)
      @user.confirm # or set a confirmed_at inside the Fabricator. Only necessary if you are using the confirmable module
      sign_in @user
      @current_user ||= @user
    end
  end
end

module DeviseRequestMacros

  # for use in request specs
  def login_admin
    @user = Fabricate(:admin)
    @user.confirm
    post_via_redirect user_session_path, 'user[email]' => @user.email, 'user[password]' => @user.password
  end

  def login_user
    @user = Fabricate(:user)
    @user.confirm
    post_via_redirect user_session_path, 'user[email]' => @user.email, 'user[password]' => @user.password
  end
end
