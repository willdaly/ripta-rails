class MessagesController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def reply
    @client = Twilio::REST::Client.new ACCOUNT_SID, AUTH_TOKEN
    body = DataParser.new(params["Body"]).getRouteId
    reply = "user stop id: #{body}"
    sms = @client.messages.create(
      from: TWILIO_NUMBER,
      to: params["From"],
      body: reply
    )
  end

end
