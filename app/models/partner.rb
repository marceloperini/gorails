class Partner < ActiveRecord::Base
  belongs_to :event
  has_many :attachments
  accepts_nested_attributes_for :attachments

  enum category: [:sponsor, :supporter, :contributor]

  validates_presence_of :name, :category
end
