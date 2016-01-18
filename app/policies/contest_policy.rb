class ContestPolicy < ApplicationPolicy
  def show?
    user.host_ids.include? record.host_id
  end

  class Scope < Scope
    def resolve
      scope.where(host_id: user.host_ids)
    end
  end
end