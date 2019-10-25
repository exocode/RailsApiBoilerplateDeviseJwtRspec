require 'rails_helper'

RSpec.describe User, type: :model do

  before(:each) do
    @user = Fabricate.build :user
  end

  it { should validate_presence_of(:password) }
  it { should validate_presence_of(:email) }

  it 'should raise error on invalid email' do
    @user.email = 'mail@mail'

    @user.validate

    expect(@user.errors.keys).to include(:email)
  end

  it 'saves a valid user successfully' do
    expect(@user.save!).to be_truthy
  end

  it 'should have an array of roles' do
    expect(@user.roles).to be_an_instance_of Array
  end

  it 'should have an visitor on create' do
    user = User.new(Fabricate.attributes_for(:user))
    user.save!
    expect(user.roles).to include(:visitor)
  end

  it 'should have an is_admin?' do
    @user.roles << :admin
    expect(@user.admin?).to be_truthy
  end
end
