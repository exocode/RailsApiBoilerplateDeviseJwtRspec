require 'rails_helper'

describe WelcomePolicy, type: :policy do
  let(:user) { User.new }

  subject { described_class }

  permissions :home? do
    it 'should allow anyone to see' do
      expect(subject).to permit(user)
    end
  end
end
