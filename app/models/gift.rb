class Gift < ActiveRecord::Base
  belongs_to :event
  has_many :attachments, as: :origin
  mount_uploader :photo, AttachmentsUploader
  accepts_nested_attributes_for :attachments


  validates_presence_of :name
end
