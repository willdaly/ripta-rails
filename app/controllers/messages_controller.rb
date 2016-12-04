class MessagesController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def reply
    @client = Twilio::REST::Client.new ACCOUNT_SID, AUTH_TOKEN
    body = params["Body"]
    reply = validStopId(body) ? "user stop id: #{body}" : "#{body} is not a valid stop id"
    sms = @client.messages.create(
      from: TWILIO_NUMBER,
      to: params["From"],
      body: reply
    )
  end

  private

  def validStopId body
    i = body.to_i
    i.between?(5, 72700) && i % 5 == 0
  end

end
