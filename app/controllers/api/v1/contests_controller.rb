module Api::V1
  class ContestsController < ApiController
    def index
      @contests = Contest.all
    end
  end
end
