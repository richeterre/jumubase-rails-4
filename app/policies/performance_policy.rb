class PerformancePolicy < ApplicationPolicy
  def show?
    if user.admin? || user.inspector?
      return true
    elsif user.host_ids.include?(record.contest.host_id)
      return true
    elsif predecessor = record.predecessor
      return user.host_ids.include?(predecessor.contest.host_id)
    end
  end

  class Scope < Scope
    def resolve
      # Get the ids of all contest categories the user can access
      contest_category_ids = ContestCategoryPolicy::Scope.new(user, ContestCategory).resolve.select("id")

      # Get all performances associated with those contest categories, either directly or by predecessor
      scope
        .includes(:predecessor)
        .where(
          "performances.contest_category_id IN (?) OR predecessors_performances.contest_category_id IN (?)",
          contest_category_ids,
          contest_category_ids
        )
        .references(:predecessor)
    end
  end
end
