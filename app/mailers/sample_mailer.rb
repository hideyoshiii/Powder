class SampleMailer < ApplicationMailer
  def send_when_update(email)
    @email = email
    mail to:      @email,
         subject: '会員情報が更新されました。'
  end
end
