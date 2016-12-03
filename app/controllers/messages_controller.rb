class MessagesController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def reply
    @client = Twilio::REST::Client.new ACCOUNT_SID, AUTH_TOKEN
    sms = @client.messages.create(
      from: TWILIO_NUMBER,
      to: params["From"],
      body: "Hello World"
    )
  end

end
