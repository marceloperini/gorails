class Attachment < ActiveRecord::Base
  belongs_to :origin, polymorphic: true

  mount_uploader :file, AttachmentsUploader

  validates_presence_of :name, :file

  validate :attachment_size_validation

  scope :situation_true, -> {where(situation: true)}

  private 

    def attachment_size_validation
      errors[:file] << "should be less than 3MB" if file.size > 3.megabytes
    end
end
