class Event < ActiveRecord::Base
  has_many :registrations

  def registered(user)
    return true if self.registrations.where(:user_id =>user ,:event_id => self.id).count >= 1
  end
end
