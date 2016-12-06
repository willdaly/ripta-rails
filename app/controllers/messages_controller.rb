class MessagesController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def reply
    sms = twilio.send_message(params["From"], "Hello World")
  end

  private

  def twilio
    TwilioService.new
  end

end
