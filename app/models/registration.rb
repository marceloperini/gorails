# app/models/registration.rb
# Model for events registrations
class Registration < ActiveRecord::Base
  # extends ...................................................................
  # includes ..................................................................
  # security (i.e. attr_accessible) ...........................................
  # relationships .............................................................
  belongs_to :event
  belongs_to :user, foreign_key: "user_id"

  before_validation :code_certified

  validates_uniqueness_of :certified_code
  # validations ...............................................................
  # callbacks .................................................................
  # scopes ....................................................................
  # additional config .........................................................
  # class methods .............................................................
  def self.is_registrated?(user_id)
    return true if self.where(user_id: user_id).count >= 1
    false
  end

  def self.to_register(user_id)
    self.create(user_id: user_id)
  end

  def code_certified

    while true do
      code = SecureRandom.hex[0..7]
      register = Registration.where(' certified_code = ? ', code).first
      break if register.nil?
    end

    self.certified_code = code
  end

  # public instance methods ...................................................
  # protected instance methods ................................................
  # private instance methods ..................................................
end

