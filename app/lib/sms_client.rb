class SmsClient
  def self.send_sms(phone_number, body)
    Rails.logger.info "Sended sms to: #{phone_number} with Body: #{body}"
  end
end