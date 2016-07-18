module API::V1
  class ContestsController < APIController
    def index
      @contests = Contest.includes(
        { contest_categories: :category },
        :host,
        :venues
      )
    end
  end
end
