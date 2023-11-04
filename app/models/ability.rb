class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user

    if user.admin?
      can :manage, :all
    else
      can :read, Post
      can :manage, Comment, user_id: user.id
    end
  end
end
