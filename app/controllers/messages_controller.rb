class MessagesController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def reply
    sms = twilio.send_message(params["From"], message(params["Body"]))
  end

  private

  def twilio
    TwilioService.new
  end

  def message posted_text
    Message.new(posted_text).text
  end

end
