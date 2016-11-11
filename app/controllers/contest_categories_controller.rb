class ContestCategoriesController < ApplicationController
  def index
    @contest = Contest.find(params[:contest_id])
    authorize(@contest, :index_contest_categories?)

    @contest_categories = policy_scope(ContestCategory).includes(:category)
  end
end
