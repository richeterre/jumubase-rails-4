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

      # Get all performances who, OR whose predecessors, belong to those contests
      # (The LEFT JOIN ensures that performances without predecessors get included, too.)
      scope
        .joins("LEFT JOIN Performances pred ON performances.predecessor_id = pred.id")
        .where("performances.contest_id IN (?) OR pred.contest_id IN (?)", contest_ids, contest_ids)
    end
  end
end
