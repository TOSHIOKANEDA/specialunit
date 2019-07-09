class ApplicationMailer < ActionMailer::Base
  default from: ENV['MAIL_ID']
  layout 'mailer'
end
