require 'rails_helper'

describe "GET /contests" do
  describe "without any parameters" do
    it "should return all contests" do
      FactoryGirl.create_list(:contest, 5)

      get api_v1_contests_path

      expect(response).to be_success
      expect(json.length).to eq(5)
    end
  end

  describe "when setting the 'public timetables' filter" do
    it "should return only contests with public timetables" do
      create_list(:contest, 3, timetables_public: false)
      public_contests = create_list(:contest, 2, timetables_public: true)

      get api_v1_contests_path, timetables_public: "1"

      expect(json.length).to eq(2)
    end
  end
end
