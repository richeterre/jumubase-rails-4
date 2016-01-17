class ApplicationController < ActionController::Base
  include Pundit

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Ensure user is logged in
  before_action :authenticate_user!

  # Ensure controller actions are authorized
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # private

  #   def user_not_authorized
  #     flash[:error] = "You are not authorized to perform this action."
  #     redirect_to request.headers["Referer"] || root_path
  #   end
end
