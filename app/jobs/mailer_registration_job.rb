class MailerRegistrationJob < ApplicationJob
  queue_as :default

  def perform(*args)
    puts"THE ARGS: #{args}"
  end
end
