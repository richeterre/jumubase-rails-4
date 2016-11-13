class ContestCategoriesController < ApplicationController
  def index
    @contest = Contest.find(params[:contest_id])
    authorize(@contest, :index_contest_categories?)

    @contest_categories = policy_scope(@contest.contest_categories)
      .includes(:category)
  end

  def destroy
    @contest_category = ContestCategory.find(params[:id])
    authorize(@contest_category)

    @contest_category.destroy
    redirect_to contest_contest_categories_path(@contest_category.contest)
  end
end
