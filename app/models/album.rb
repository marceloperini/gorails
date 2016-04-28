class Album < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller && controller.current_user }
  has_many :images, dependent: :destroy

  validates_presence_of :title
  validates_uniqueness_of :title

  accepts_nested_attributes_for :images,allow_destroy: true, reject_if: :all_blank
end
