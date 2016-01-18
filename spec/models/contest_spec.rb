require 'rails_helper'

RSpec.describe Contest, type: :model do

  let (:contest) { build(:contest) }

  subject { contest }

  it { should be_valid }

  describe "without a season" do
    before { contest.season = nil }
    it { should_not be_valid }
  end

  describe "without a level" do
    before { contest.level = nil }
    it { should_not be_valid }
  end

  describe "with a too low level" do
    before { contest.level = 0 }
    it { should_not be_valid }
  end

  describe "with a too high level" do
    before { contest.level = 4 }
    it { should_not be_valid }
  end

  describe "without an associated host" do
    before { contest.host = nil }
    it { should_not be_valid }
  end

  describe "without a start date" do
    before { contest.begins = nil }
    it { should_not be_valid }
  end

  describe "without an end date" do
    before { contest.ends = nil }
    it { should_not be_valid }
  end

  describe "with an end date before the start date" do
    before { contest.ends = contest.begins - 1.day }
    it { should_not be_valid }
  end

  describe "without a signup deadline" do
    before { contest.signup_deadline = nil }
    it { should_not be_valid }
  end

  describe "with a signup deadline after the start date" do
    before { contest.signup_deadline = contest.begins + 1.second }
    it { should_not be_valid }
  end

  it "should have the correct name" do
    host = build(:host, name: "DS Jumutown")
    contest = build(:contest, season: 53, level: 2, host: host)
    expect(contest.name).to eq("DS Jumutown, LW 2016")
  end
end
