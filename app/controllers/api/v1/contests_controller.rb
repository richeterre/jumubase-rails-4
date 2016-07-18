module API::V1
  class ContestsController < APIController
    def index
      @contests = Contest.includes(:host)
    end
  end
end
