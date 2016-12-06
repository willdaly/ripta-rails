class Message < ActiveRecord::Base

  def text
    valid_stop_id ? "your bus is coming soon" : error
  end

  private

  def valid_stop_id
    Stop.find_by_id(self.posted_text)
  end

  def error
    self.posted_text + " is not a valid stop id"
  end

end
