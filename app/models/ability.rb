class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, User
    can :manage, User, :id => user.id

    can :manage, Order, :orderer_id => user.id
    can :accept, Order, :accepter_id => nil
    can :unaccept, Order, :accepter_id => user.id

    # TODO: These will need to be tightened once we have a little more of a lifecycle around payments.
    can :manage, Payment, :payer_id => user.id
    can :manage, Payment, :recipient_id => user.id

    # TODO: Tighten these?
    can :manage, Restaurant
    can :manage, Item
  end
end
