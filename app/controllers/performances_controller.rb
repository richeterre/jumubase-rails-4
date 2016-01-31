class PerformancesController < ApplicationController
  def index
    contest = Contest.find(params[:contest_id])
    # TODO: authorize(contest)
    @performances = policy_scope(contest.performances)
  end

  def show
    @performance = Performance.find(params[:id])
    authorize(@performance)
  end
end
