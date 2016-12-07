class Stop < ActiveRecord::Base
  has_many :stop_routes, :dependent => :destroy
  has_many :routes, :through => :stop_routes
end
