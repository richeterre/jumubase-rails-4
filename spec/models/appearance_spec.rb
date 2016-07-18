# == Schema Information
#
# Table name: appearances
#
#  id               :integer          not null, primary key
#  performance_id   :integer          not null
#  participant_id   :integer          not null
#  instrument_id    :integer          not null
#  participant_role :string           not null
#  points           :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'rails_helper'

RSpec.describe Appearance, type: :model do

  let (:appearance) { build(:appearance) }

  subject { appearance }

  # Associations

  it { should respond_to(:performance) }
  it { should respond_to(:participant) }
  it { should respond_to(:instrument) }

  describe "when created with a nested participant" do
    before do
      # Must be created _before_ to not break change-by-1 assertions
      @performance = create(:performance)
    end

    let (:instrument) { create(:instrument) }
    let (:params) do
      {
        performance_id: @performance.id,
        participant_attributes: attributes_for(:participant),
        instrument_id: instrument.id,
        participant_role: 'soloist'
      }
    end

    subject { lambda { Appearance.create!(params) } }

    it { should change(Appearance, :count).by(1) }
    it { should change(Participant, :count).by(1) }
  end

  # Validations

  it { should be_valid }

  describe "without an associated performance" do
    before { appearance.performance = nil }
    it { should_not be_valid }
  end

  describe "without an associated participant" do
    before { appearance.participant = nil }
    it { should_not be_valid }
  end

  describe "without an associated instrument" do
    before { appearance.instrument = nil }
    it { should_not be_valid }
  end

  describe "without a participant role" do
    before { appearance.participant_role = nil }
    it { should_not be_valid }
  end

  describe "with an invalid participant role" do
    it "should not be valid" do
      ['S', 'E', 'B', 'solo', 'ens', 'acc'].each do |invalid_role|
        appearance.participant_role = invalid_role
        expect(appearance).not_to be_valid
      end
    end
  end

  describe "with a valid participant role" do
    it "should be valid" do
      JUMU_PARTICIPANT_ROLES.each do |valid_role|
        appearance.participant_role = valid_role
        expect(appearance).to be_valid
      end
    end
  end

  # Appearance types

  describe "with a soloist" do
    before { appearance.participant_role = 'soloist' }

    it "tells it's a solo appearance" do
      expect(appearance.solo?).to be_truthy
    end

    it "tells it's no ensemble appearance" do
      expect(appearance.ensemble?).to be_falsy
    end

    it "tells it's no accompaniment appearance" do
      expect(appearance.accompaniment?).to be_falsy
    end
  end

  describe "with an ensemblist" do
    before { appearance.participant_role = 'ensemblist' }

    it "tells it's no solo appearance" do
      expect(appearance.solo?).to be_falsy
    end

    it "tells it's an ensemble appearance" do
      expect(appearance.ensemble?).to be_truthy
    end

    it "tells it's no accompaniment appearance" do
      expect(appearance.accompaniment?).to be_falsy
    end
  end

  describe "with an accompanist" do
    before { appearance.participant_role = 'accompanist' }

    it "tells it's no solo appearance" do
      expect(appearance.solo?).to be_falsy
    end

    it "tells it's no ensemble appearance" do
      expect(appearance.ensemble?).to be_falsy
    end

    it "tells it's an accompaniment appearance" do
      expect(appearance.accompaniment?).to be_truthy
    end
  end
end
