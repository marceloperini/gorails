# Abily class for CanCan gem
class Ability
  include CanCan::Ability

  def initialize(user)
    if user.has_role? :admin
      can :manage, :all
    else
      can :read, :all
      can :register,:all
    end
  end
end
