class PagesController < ApplicationController
  after_action :skip_authorization

  def home
  end
end
