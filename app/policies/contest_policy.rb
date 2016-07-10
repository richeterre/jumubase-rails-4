class ContestPolicy < ApplicationPolicy
  def show?
    user.admin? || user.inspector? || user.host_ids.include?(record.host_id)
  end

  def create?
    user.admin?
  end

  def index_performances?
    user.admin? || user.inspector? || user.host_ids.include?(record.host_id)
  end

  class Scope < Scope
    def resolve
      if user.admin? || user.inspector?
        scope
      else
        scope.where(host_id: user.host_ids)
      end
    end
  end
end
