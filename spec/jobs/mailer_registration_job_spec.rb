require 'rails_helper'

RSpec.describe MailerRegistrationJob, type: :job do
  describe '#perform_later' do
    it 'uploads a backup' do
      ActiveJob::Base.queue_adapter = :test
      expect {
        MailerRegistrationJob.perform_later('backup')
      }.to have_enqueued_job
    end
  end
end
