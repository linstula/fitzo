class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new

    if user
      can :read, TrainerProfile
      can [:create, :read], Recommendation
      can [:update, :destroy], Recommendation do |rec|
        rec && rec.user == user
      end
      can [:read], Location

      if user.role == "trainer"
        can :manage, TrainerProfile, user_id: user.id
        can :manage, Location, trainer_profile: { user_id: user.id }
        can :manage, Service, trainer_profile: { user_id: user.id }
      end
    end
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
