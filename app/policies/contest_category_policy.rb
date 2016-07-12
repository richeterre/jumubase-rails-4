class ContestCategoryPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin? || user.inspector?
        scope
      else
        # Get the ids of all contests the user can access
        contest_ids = ContestPolicy::Scope.new(user, Contest).resolve.select("id")
        scope.where(contest_id: contest_ids)
      end
    end
  end
end
