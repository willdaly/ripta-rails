class TwilioService
  attr_reader :client

  def initialize
    @client = Twilio::REST::Client.new ACCOUNT_SID, AUTH_TOKEN
  end

  def send_message(to, message)
    client.messages.create(
      from: TWILIO_NUMBER,
      to: to,
      body: message
    )
  end

end
