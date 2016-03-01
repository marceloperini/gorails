class Event < ActiveRecord::Base
  resourcify

has_many :registrations
end
