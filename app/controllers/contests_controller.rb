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

    @rounds = available_rounds
  end

  def create
    @contest = Contest.new(contest_params)
    authorize(@contest)

    if @contest.save
      redirect_to contests_path
    else
      @rounds = available_rounds
      render 'new'
    end
  end

  def edit
    @contest = Contest.find(params[:id])
    authorize(@contest)

    @rounds = available_rounds
  end

  def update
    @contest = Contest.find(params[:id])
    authorize(@contest)

    if @contest.update_attributes(contest_params)
      redirect_to @contest
    else
      @rounds = available_rounds
      render 'edit'
    end
  end

  private

    def contest_params
      params
        .require(:contest)
        .permit(:season, :round, :host_id, :begins, :ends, :signup_deadline, :certificate_date)
    end

    def available_rounds
      [1, 2] # Only allow adding contests for these rounds
    end
end
