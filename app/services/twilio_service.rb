class TwilioService
  attr_reader :client

  def initialize
    @client = Twilio::REST::Client.new ENV['ACCOUNT_SID'], ENV['AUTH_TOKEN']
  end

  def send_message(to, message)
    client.messages.create(
      from: ENV['TWILIO_NUMBER'],
      to: to,
      body: message
    )
  end

end
