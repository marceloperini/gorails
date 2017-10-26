# app/models/user_observer.rb
class UserObserver < ActiveRecord::Observer
observe User
  SIGN_IN_REWARDS =[{:count =>1, :points =>100},
                    {:count =>5, :points =>50},
                    {:count =>10, :points =>10},
                    {:count =>20, :points =>10},
                    {:count =>50, :points =>1},
                    {:count =>100, :points =>0},
                    {:count =>500, :points =>0},
                    {:count =>1000, :points =>0},
                    {:count =>5000, :points =>0},
                    {:count =>10000, :points =>0},
                    {:count =>50000, :points =>0},
                    {:count =>100000, :points =>0}]

  def after_update(user)
    if eligible_for_sign_in_medal? user
      sign_in_goal(user).complete_for user
    end
  end

  private

  def eligible_for_sign_in_medal?(user)
    SIGN_IN_REWARDS.map{|a| a[:count]}.include? user.sign_in_count and !Gamification::Goal.where(rewarding_type: user.class.to_s, rewarding_id: user.id,count:user.sign_in_count).first.present?
  end

  def sign_in_goal(user)
    goal = Gamification::Goal.create(rewarding_type: user.class, rewarding_id: user.id, points: SIGN_IN_REWARDS.select{|a| a[:count] == user.sign_in_count}.first[:points],count:user.sign_in_count)
    goal.create_medal do |medal|
      medal.name = 'Logar'
      medal.image = File.open("#{Rails.root}/app/assets/images/medals/login-medal.png")
      medal.description = "Efetuou Login #{user.sign_in_count} vezes"
    end
    goal
  end


end