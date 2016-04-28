class Gift < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller && controller.current_user }
  belongs_to :event
  has_many :attachments, as: :origin
  has_many :winners
  mount_uploader :photo, AttachmentsUploader
  accepts_nested_attributes_for :attachments
  accepts_nested_attributes_for :winners, allow_destroy: true, reject_if: :all_blank


  validates_presence_of :name
end
