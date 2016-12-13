# == Schema Information
#
# Table name: venues
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  host_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Venue, type: :model do

  let (:venue) { build(:venue) }

  subject { venue }

  it { is_expected.to be_valid }

  describe "without a name" do
    before { venue.name = nil }
    it { is_expected.not_to be_valid }
  end

  describe "without an associated host" do
    before { venue.host = nil }
    it { is_expected.not_to be_valid }
  end
end
