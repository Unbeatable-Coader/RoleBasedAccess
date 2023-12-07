class Ability
    include CanCan::Ability

    def initialize(user)
      alias_action :create, :read, :update, :destroy, :to => :crud
      if user
          if user.usertype == "manager"
              can :crud, Task, :id => user.task_id
          elsif user.usertype == "admin"
              can :manage, :all
          end
      end
    end
  end
