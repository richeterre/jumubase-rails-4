require 'rails_helper'

RSpec.describe Participant, type: :model do

  let (:participant) { build(:participant) }

  subject { participant }

  it { should be_valid }

  describe "without a first name" do
    before { participant.first_name = nil }
    it { should_not be_valid }
  end

  describe "without a last name" do
    before { participant.last_name = nil }
    it { should_not be_valid }
  end

  describe "without a birthdate" do
    before { participant.birthdate = nil }
    it { should_not be_valid }
  end

  describe "without a country code" do
    before { participant.country_code = nil }
    it { should_not be_valid }
  end

  describe "without a phone number" do
    before { participant.phone = nil }
    it { should_not be_valid }
  end

  describe "without an email" do
    before { participant.email = nil }
    it { should_not be_valid }
  end

  describe "with an invalid email" do
    it "should not be valid" do
      ["a", "@example", "@example.org", "a@example"].each do |invalid_email|
        participant.email = invalid_email
        expect(participant).not_to be_valid
      end
    end
  end
end
