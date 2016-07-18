require 'rails_helper'

describe "GET /performances" do
  describe "for a contest with non-public timetables" do
    let (:contest) { create(:contest, timetables_public: false) }

    it "should return an empty 404 reponse" do
      get api_v1_contest_performances_path(contest.id)

      expect(response).to have_http_status(404)
      expect(response.body).to be_empty
    end
  end

  describe "for a contest with public timetables" do
    let (:contest) { create(:contest, timetables_public: true) }

    it "should return the contest's performances" do
      contest_category = create(:contest_category, contest: contest)
      create_list(:performance, 3, contest_category: contest_category)

      get api_v1_contest_performances_path(contest.id)

      expect(response).to have_http_status(200)
      expect(json.length).to eq(3)
    end
  end
end

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
    it "should create a new performance" do
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
    it "should return a list of validation errors" do
      params[:performance][:contest_category_id] = nil
      params[:performance][:appearances_attributes][0][:instrument_id] = nil

      post api_v1_contest_performances_path(contest.id), params

      expect(response).to have_http_status(400)
      expect(json.length).to eq(2)
    end
  end
end
