class Event < ActiveRecord::Base

	belongs_to :user

  has_many :registrations

  delegate :is_registrated?, :to_register, to: :registrations, prefix: true, allow_nil: true

  alias_method :is_registrated?, :registrations_is_registrated?
  alias_method :to_register, :registrations_to_register

  def exceeded_limit?
  	return true if self.registrations.size >= self.participants_limit
  	false
  end

end
