module API::V1
  class PerformancesController < APIController

    def create
      @performance = Performance.new(performance_params)
      if @performance.save
        render status: :created
      else
        render json: @performance.errors, status: :bad_request
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
