class Trip < ActiveRecord::Base
  belongs_to :route
  has_many :stops, through: :route
end
