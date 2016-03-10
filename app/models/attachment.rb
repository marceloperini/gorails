class Attachment < ActiveRecord::Base
  belongs_to :origin, polymorphic: true

  mount_uploader :data, AttachmentsUploader

  validates_presence_of :name, :data
  validate :attachment_size_validation

  scope :situation_true, -> {where(stiuation: true)}

  scope :return_images, -> {where(content_type: '/image/')}

  def self.return_images

  end
  
  # def self.verify_by_file_type(file_type)
  #   extension = File.extname(file_type)
  #   data_extension = File.extname(self.data)
  #   self.where(data_extension) == extension
  # end
  private 

    def attachment_size_validation
      errors[:data] << "should be less than 3MB" if data.size > 3.megabytes
    end
end
