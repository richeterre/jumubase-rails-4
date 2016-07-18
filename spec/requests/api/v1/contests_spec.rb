require 'rails_helper'

describe "GET /contests" do
  describe "without any parameters" do
    it "should return all contests ordered by descending start date" do
      c1 = create(:contest, begins: Date.new(2000, 1, 2))
      c2 = create(:contest, begins: Date.new(2000, 1, 3))
      c3 = create(:contest, begins: Date.new(2000, 1, 1))

      get api_v1_contests_path

      expect(response).to be_success
      expect(json_ids(json)).to eq(contest_ids([c2, c1, c3]))
    end
  end

  describe "when setting the 'public timetables' filter" do
    it "should return only contests with public timetables" do
      create_list(:contest, 3, timetables_public: false)
      public_contests = create_list(:contest, 2, timetables_public: true)

      get api_v1_contests_path, timetables_public: "1"

      expect(json_ids(json)).to match_array(contest_ids(public_contests))
    end
  end

  private

    def json_ids(json)
      json.map { |c| c['id'] }
    end

    # Returns string IDs from an array of contests
    def contest_ids(contests)
      contests.map { |c| c.id.to_s }
    end
end
