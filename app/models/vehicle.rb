class Vehicle < ActiveRecord::Base
  belongs_to :trip
  belongs_to :route
  belongs_to :stop
  has_many :stops, :through => :trip

  def stops_away user_stop
    usi = user_stop_index(user_stop)
    csi = current_stop_index
    usi > csi ? usi - csi : nil
  end

  def stops_away_string user_stop
    usi = user_stop_index(user_stop)
    csi = current_stop_index
    distance = usi - csi
    usi > csi ? "#{trip.trip_headsign} is #{distance} #{stop_or_stops(distance)} away" : nil
  end

  private

  def user_stop_index user_stop
    stops.index(user_stop)
  end

  def current_stop_index
    stops.index(stop)
  end

  def stop_or_stops distance
    distance == 1 ? "stop" : "stops"
  end

end
