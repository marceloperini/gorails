# == Schema Information
#
# Table name: attachments
#
#  id          :integer          not null, primary key
#  name        :string
#  type        :string
#  origin_type :string
#  situation   :boolean
#  origin_id   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  file        :string
#  file_type   :string
#
# Indexes
#
#  index_attachments_on_origin_type_and_origin_id  (origin_type,origin_id)
#

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
