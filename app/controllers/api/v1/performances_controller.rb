module API::V1
  class PerformancesController < APIController

    def index
      contest = Contest.find(params[:contest_id])
      if !contest.timetables_public
        return render nothing: true, status: :not_found
      end

      @performances = contest.performances.includes(
        { contest_category: :category },
        { appearances: [:participant, :instrument] }
      )
    end

    def create
      @performance = Performance.new(performance_params)
      if @performance.save
        render status: :created
      else
        render json: @performance.errors, status: :unprocessable_entity
      end
    end

    private

      def performance_params
        params.require(:performance).permit(
          :contest_category_id,
          {
            appearances_attributes: [
              :participant_id,
              {
                participant_attributes: [
                  :id,
                  :first_name,
                  :last_name,
                  :birthdate,
                  :country_code,
                  :phone,
                  :email
                ]
              },
              :participant_role,
              :instrument_id
            ]
          }
        )
      end
  end
end
