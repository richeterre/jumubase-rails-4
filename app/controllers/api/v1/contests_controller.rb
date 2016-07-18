module API::V1
  class ContestsController < APIController
    def index
      @contests = Contest.includes(
        { contest_categories: :category },
        :host,
        :venues
      )

      if timetable_filter = params[:timetables_public]
        filter_value = (timetable_filter == "1")
        @contests = @contests.where(timetables_public: filter_value)
      end
    end
  end
end
