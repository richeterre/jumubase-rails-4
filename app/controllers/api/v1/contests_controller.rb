module API::V1
  class ContestsController < APIController
    def index
      @contests = Contest.all
    end
  end
end
