# == Schema Information
#
# Table name: partners
#
#  id         :integer          not null, primary key
#  name       :string
#  link       :string
#  order      :integer
#  site       :boolean
#  event_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  category   :integer
#  logo       :string
#
# Indexes
#
#  index_partners_on_event_id  (event_id)
#
# Foreign Keys
#
#  fk_rails_...  (event_id => events.id)
#

class Partner < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller && controller.current_user }
  belongs_to :event
  has_many :attachments, as: :origin
  mount_uploader :logo, AttachmentsUploader
  accepts_nested_attributes_for :attachments

  enum category: [:sponsor, :supporter, :contributor]

  validates_presence_of :name, :category
end
