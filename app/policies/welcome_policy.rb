class WelcomePolicy < ApplicationPolicy
  attr_reader :current_user, :model

  def initialize(current_user, model)
    @current_user = current_user
    @user = model
  end

  def home?
    true
  end

  def check?
    true
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
