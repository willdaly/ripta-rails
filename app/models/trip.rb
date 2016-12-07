class Trip < ActiveRecord::Base
  has_one :trip_route, :dependent => :destroy
  has_one :route, :through => :trip_route
end
