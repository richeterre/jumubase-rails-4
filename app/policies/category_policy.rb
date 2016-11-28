class CategoryPolicy < ApplicationPolicy
  def index
    user.admin?
  end

  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        nil
      end
    end
  end
end
