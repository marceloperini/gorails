class LinkCategory < ActiveRecord::Base
  resourcify
  has_many :links
end
