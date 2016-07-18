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

  describe "with valid parameters" do
    it "creates a new performance" do
      expect {
        post api_v1_contest_performances_path(contest.id), params
      }.to change(Performance, :count).by(1)

      expect(response).to have_http_status(201)
    end

    describe "having an existing participant" do
      before do
        @participant = create(:participant)
        appearance_attributes = params[:performance][:appearances_attributes][0]
        appearance_attributes[:participant_id] = @participant.id
        appearance_attributes[:participant_attributes] = @participant.attributes
          .update({ "first_name" => "Different" })
      end

      subject { lambda { post api_v1_contest_performances_path(contest.id), params } }

      it { should change(Performance, :count).by(1) }
      it { should change(Appearance, :count).by(1) }
      it { should change(Participant, :count).by(0) }
      it { should change { Participant.find(@participant.id).first_name }.to("Different") }
    end
  end

  describe "with invalid parameters" do
    it "returns a list of validation errors" do
      params[:performance][:contest_category_id] = nil
      params[:performance][:appearances_attributes][0][:instrument_id] = nil

      post api_v1_contest_performances_path(contest.id), params

      expect(response).to have_http_status(400)
      expect(json.length).to eq(2)
    end
  end
end
