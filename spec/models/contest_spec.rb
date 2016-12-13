# == Schema Information
#
# Table name: contests
#
#  id                :integer          not null, primary key
#  season            :integer          not null
#  round             :integer          not null
#  host_id           :integer          not null
#  begins            :date             not null
#  ends              :date             not null
#  certificate_date  :date
#  signup_deadline   :date             not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  timetables_public :boolean          default(FALSE), not null
#

require 'rails_helper'

RSpec.describe Contest, type: :model do

  let (:contest) { build(:contest) }

  subject { contest }

  # Associations

  it { is_expected.to respond_to(:host) }
  it { is_expected.to respond_to(:contest_categories) }
  it { is_expected.to respond_to(:categories) }
  it { is_expected.to respond_to(:performances) }

  describe "when destroyed" do
    it "should destroy its associated contest categories" do
      contest = create(:contest, contest_categories: build_list(:contest_category, 3))
      expect { contest.destroy }.to change(ContestCategory, :count).by(-3)
    end
  end

  # Validations

  it { is_expected.to be_valid }

  describe "without a season" do
    before { contest.season = nil }
    it { is_expected.not_to be_valid }
  end

  describe "without a round" do
    before { contest.round = nil }
    it { is_expected.not_to be_valid }
  end

  describe "with a too low round" do
    before { contest.round = 0 }
    it { is_expected.not_to be_valid }
  end

  describe "with a too high round" do
    before { contest.round = 4 }
    it { is_expected.not_to be_valid }
  end

  describe "without an associated host" do
    before { contest.host = nil }
    it { is_expected.not_to be_valid }
  end

  describe "without a start date" do
    before { contest.begins = nil }
    it { is_expected.not_to be_valid }
  end

  describe "without an end date" do
    before { contest.ends = nil }
    it { is_expected.not_to be_valid }
  end

  describe "with an end date before the start date" do
    before { contest.ends = contest.begins - 1.day }
    it { is_expected.not_to be_valid }
  end

  describe "without a signup deadline" do
    before { contest.signup_deadline = nil }
    it { is_expected.not_to be_valid }
  end

  describe "with a signup deadline after the start date" do
    before { contest.signup_deadline = contest.begins + 1.second }
    it { is_expected.not_to be_valid }
  end

  # Instance Methods

  it "should have the correct name" do
    host = build(:host, name: "DS Jumutown")
    contest = build(:contest, season: 53, round: 2, host: host)
    expect(contest.name).to eq("DS Jumutown, LW 2016")
  end
end
