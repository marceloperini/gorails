class Attachment < ActiveRecord::Base
  belongs_to :origin, polymorphic: true

  mount_uploader :data, AttachmentsUploader

  validates_presence_of :name, :data

  scope :situation_true, -> {where(stiuation: true)}
  
  # def self.verify_by_file_type(file_type)
  #   extension = File.extname(file_type)
  #   data_extension = File.extname(self.data)
  #   self.where(data_extension) == extension
  # end
end
