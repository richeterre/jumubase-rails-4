class ApplicationController < ActionController::Base
  include Pundit

  # Prevent CSRF attacks by raising an exception.
  protect_from_forgery with: :exception

  # Ensure user is logged in
  before_action :authenticate_user!

  # Ensure non-Devise controller actions are authorized
  after_action :verify_authorized, except: :index, unless: :devise_controller?
  after_action :verify_policy_scoped, only: :index, unless: :devise_controller?

  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  # private

  #   def user_not_authorized
  #     flash[:error] = "You are not authorized to perform this action."
  #     redirect_to request.headers["Referer"] || root_path
  #   end
end
