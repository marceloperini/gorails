# Abily class for CanCan gem
class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      if user.has_role? :admin
        can :manage, :all
      else
        can :read, :Event
        can :read, :FinancialTransaction
        can :register, :all
      end
    end
  end
end
