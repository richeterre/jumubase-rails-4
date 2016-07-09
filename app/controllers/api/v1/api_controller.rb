module API::V1
  class APIController < ActionController::Base
    # Prevent CSRF attacks by providing an empty session.
    protect_from_forgery with: :null_session
  end
end
