# == Schema Information
#
# Table name: gifts
#
#  id          :bigint(8)        not null, primary key
#  name        :string
#  description :text
#  event_id    :bigint(8)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  photo       :string
#
# Indexes
#
#  index_gifts_on_event_id  (event_id)
#
# Foreign Keys
#
#  fk_rails_...  (event_id => events.id)
#

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
