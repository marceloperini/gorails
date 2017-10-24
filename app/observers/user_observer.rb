# app/models/user_observer.rb
class UserObserver < ActiveRecord::Observer

  SIGN_IN_REWARDS =[1, 5, 10, 20, 50, 100, 500, 1000, 5000, 10000, 50000, 100000]

  def after_save(user)
    if eligible_for_sign_in_medal? user
      sign_in_goal(user).complete_for user
    end
  end

  private

  def eligible_for_sign_in_medal?(user)
    SIGN_IN_REWARDS.include? user.sign_in_count
  end

  def sign_in_goal(user)
    goal = Gamification::Goal.create(rewarding_type: user.class, rewarding_id: user.id, points: points(user))
    goal.create_medal do |medal|
      medal.name = 'Logar'
      medal.image = File.open("#{Rails.root}/app/assets/images/medals/login-medal.png")
      medal.description = "Efetuou Login #{user.sign_in_count} vezes"
    end
    goal
  end

  def points(user)
    case user.sign_in_count
      when 1
        100
      when 5
        50
      when 10
        10
      when 20
        10
      when 100
        1
      else
        0
    end
  end

end