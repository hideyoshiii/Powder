class ApplicationMailer < ActionMailer::Base
  default from:     "A.Date",
          bcc:      "adate.ask@gmail.com",
          reply_to: "adate.ask@gmail.com"
  layout 'mailer'
end
