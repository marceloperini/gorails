# app/models/user_observer.rb
class UserObserver < ActiveRecord::Observer

  def after_save(user)
    if eligible_for_sign_in_50_medal? user
      sign_in_50_goal.complete_for user
    end
  end

  private

  def eligible_for_sign_in_50_medal?(user)
    user.sign_in_count >= 50
  end

  def sign_in_50_goal
    goal = GoGamification::Goal.create
    goal.create_medal do |medal|
      medal.name = 'Login'
      medal.image =  File.open("#{Rails.root}/app/assets/images/medals/login-medal.png")
      medal.description = 'Efetuou Login 50 vezes'
    end
    goal
  end
end