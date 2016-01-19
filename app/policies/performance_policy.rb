class PerformancePolicy < ApplicationPolicy
  def show?
    # Check if the user's hosts include either this performance's contest,
    # or that of its predecessor
    if user.host_ids.include?(record.contest.host_id)
      return true
    elsif predecessor = record.predecessor
      return user.host_ids.include?(predecessor.contest.host_id)
    end
  end

  class Scope < Scope
    def resolve
      # Get the ids of all contests the user can access
      contest_ids = ContestPolicy::Scope.new(user, Contest).resolve.select("id")

      # Get all performances associated with those contests, either directly or by predecessor
      scope
        .includes(:predecessor)
        .where(
          "performances.contest_id IN (?) OR predecessors_performances.contest_id IN (?)",
          contest_ids,
          contest_ids
        )
        .references(:predecessor)
    end
  end
end
