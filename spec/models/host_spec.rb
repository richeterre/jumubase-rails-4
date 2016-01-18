require 'rails_helper'

RSpec.describe Host, type: :model do

  let (:host) { build(:host) }

  subject { host }

  it { should be_valid }

  describe "without a name" do
    before { host.name = nil }
    it { should_not be_valid }
  end

  describe "without a city" do
    before { host.city = nil }
    it { should_not be_valid }
  end

  describe "without a country code" do
    before { host.country_code = nil }
    it { should_not be_valid }
  end

  describe "with a lowercase country code" do
    before { host.country_code = "ab" }
    it { should_not be_valid }
  end

  describe "with a too short country code" do
    before { host.country_code = "A" }
    it { should_not be_valid }
  end

  describe "with a too long country code" do
    before { host.country_code = "ABC" }
    it { should_not be_valid }
  end

  describe "without a time zone" do
    before { host.time_zone = nil }
    it { should_not be_valid }
  end
end
