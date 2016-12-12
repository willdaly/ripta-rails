class Message < ActiveRecord::Base
  attr_reader :stop

  def initialize posted_text
    @posted_text = posted_text
    @stop = Stop.find_by_id(posted_text)
  end

  def text
    valid_stop_id ? "your bus is coming soon" : error
  end

  private

  def error
    @posted_text + " is not a valid stop id"
  end

end
