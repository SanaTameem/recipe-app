class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= current_user

    return unless user.present?

    can(:manage, Food, user:)
    can(:manage, Recipe, user:)
    can :read, :all
  end
end
