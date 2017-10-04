# app/models/event.rb
class Event < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: ->(controller, model) { controller && controller.current_user }

  include ActionView::Helpers
  resourcify
  belongs_to :user
  has_many :partners
  has_many :gifts
  has_many :albums
  accepts_nested_attributes_for :partners, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :gifts, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :albums, allow_destroy: true, reject_if: :all_blank


  has_many :registrations

  delegate :is_registrated?, :to_register, to: :registrations, prefix: true, allow_nil: true

  alias_method :is_registrated?, :registrations_is_registrated?
  alias_method :to_register, :registrations_to_register

# Returns false if event is full
  def exceeded_limit?
    return true if self.registrations.size >= self.participants_limit
    false
  end

  validates_presence_of :name, :description, :local, :participants_limit, :start_at, :end_at
# Returns duration of event
  def event_duration
    ((self.end_at - self.start_at) / 1.hour).round
  end

  def event_happened?
    DateTime.now > self.end_at
  end

  def inscriptions_open?
    self.status
  end

  def remaining_vacancies
    self.participants_limit - self.registrations.size
  end


end
