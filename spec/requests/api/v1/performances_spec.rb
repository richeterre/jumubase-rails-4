require 'rails_helper'

describe "POST /performances" do

  let (:contest) { create(:contest) }
  let (:contest_category) { create(:contest_category, contest: contest) }
  let (:instrument) { create(:instrument) }
  let (:params) do
    {
      performance: {
        contest_category_id: contest_category.id,
        appearances_attributes: [
          {
            participant_attributes: attributes_for(:participant),
            instrument_id: instrument.id,
            participant_role: 'soloist'
          }
        ]
      }
    }
  end

  it "creates a new performance" do
    expect {
      post "/api/v1/contests/#{contest.id}/performances", params
    }.to change(Performance, :count).by(1)

    expect(response).to have_http_status(201)
  end

  describe "with invalid parameters" do
    it "returns a list of validation errors" do
      params[:performance][:contest_category_id] = nil
      params[:performance][:appearances_attributes][0][:instrument_id] = nil

      post "/api/v1/contests/#{contest.id}/performances", params

      json = JSON.parse(response.body)

      expect(response).to have_http_status(400)
      expect(json.length).to eq(2)
    end
  end
end
