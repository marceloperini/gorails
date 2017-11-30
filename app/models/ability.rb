# Abily class for CanCan gem
class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      if user.has_role? :admin
        can :manage, :all
      else
        can :read, :Event
        can :read, Jobs::Job
        can :new, Jobs::Job
        can :create, Jobs::Job
        can [:edit,:update], Jobs::Job, :status => 1,:user_id => user.id
        can [:update], Gamification::Inventory,:user_id => user.id
        can :read, :FinancialTransaction
        can :register, :all
      end
    end
  end
end
