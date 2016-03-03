class Attachment < ActiveRecord::Base
  belongs_to :origin, polymorphic: true

  mount_uploader :file, AttachmentsUploader

  validates_presence_of :name, :file
end
