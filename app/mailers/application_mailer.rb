class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch('MAIL_SENDER_EMAIL')
  layout 'mailer'
end
