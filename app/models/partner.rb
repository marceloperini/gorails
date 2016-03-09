class Partner < ActiveRecord::Base
  belongs_to :event
  enum category: [:sponsor, :supporter, :contributor]

  validates_presence_of :name, :category, :event_id
end
