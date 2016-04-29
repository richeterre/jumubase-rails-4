class ContestsController < ApplicationController
  def index
    @contests = policy_scope(Contest)
      .includes(:host)
  end

  def show
    @contest = Contest.find(params[:id])
    authorize(@contest)
  end

  def new
    @contest = Contest.new
    authorize(@contest)

    @levels = available_levels
  end

  def create
    @contest = Contest.new(contest_params)
    authorize(@contest)

    if @contest.save
      redirect_to contests_path
    else
      @levels = available_levels
      render 'new'
    end
  end

  private

    def contest_params
      params
        .require(:contest)
        .permit(:season, :level, :host_id, :begins, :ends, :signup_deadline, :certificate_date)
    end

    def available_levels
      [1, 2] # Only allow adding contests for these rounds
    end
end
