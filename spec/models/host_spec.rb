# == Schema Information
#
# Table name: hosts
#
#  id           :integer          not null, primary key
#  name         :string           not null
#  city         :string           not null
#  country_code :string           not null
#  time_zone    :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'rails_helper'

RSpec.describe Host, type: :model do

  let (:host) { build(:host) }

  subject { host }

  it { is_expected.to be_valid }

  describe "without a name" do
    before { host.name = nil }
    it { is_expected.not_to be_valid }
  end

  describe "without a city" do
    before { host.city = nil }
    it { is_expected.not_to be_valid }
  end

  describe "without a country code" do
    before { host.country_code = nil }
    it { is_expected.not_to be_valid }
  end

  describe "with a lowercase country code" do
    before { host.country_code = "ab" }
    it { is_expected.not_to be_valid }
  end

  describe "with a too short country code" do
    before { host.country_code = "A" }
    it { is_expected.not_to be_valid }
  end

  describe "with a too long country code" do
    before { host.country_code = "ABC" }
    it { is_expected.not_to be_valid }
  end

  describe "without a time zone" do
    before { host.time_zone = nil }
    it { is_expected.not_to be_valid }
  end
end
