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

  it { is_expected.to respond_to(:performance) }
  it { is_expected.to respond_to(:participant) }
  it { is_expected.to respond_to(:instrument) }

  describe "when created with a nested participant" do
    before do
      # Must be created _before_ to not break change-by-1 assertions
      @performance = create(:performance)
    end

    let (:instrument) { create(:instrument) }
    let (:params) do
      {
        performance_id: @performance.id,
        instrument_id: instrument.id,
        participant_role: 'soloist'
      }
    end

    subject { lambda { Appearance.create!(params) } }

    describe "that doesn't exist yet" do
      before do
        params[:participant_attributes] = attributes_for(:participant)
      end

      it { is_expected.to change(Appearance, :count).by(1) }
      it { is_expected.to change(Participant, :count).by(1) }
    end

    describe "that already exists" do
      before { @participant = create(:participant) }

      describe "with identical data" do
        before do
          params[:participant_id] = @participant.id
          params[:participant_attributes] = @participant.attributes
        end

        it { is_expected.to change(Appearance, :count).by(1) }
        it { is_expected.to change(Participant, :count).by(0) }
      end

      describe "with different data" do
        before do
          params[:participant_id] = @participant.id
          params[:participant_attributes] = @participant.attributes
              .update({ "first_name" => "Different" })
        end

        it { is_expected.to change(Appearance, :count).by(1) }
        it { is_expected.to change(Participant, :count).by(0) }
        it { is_expected.to change {
          Participant.find(@participant.id).first_name
        }.to("Different") }
      end
    end
  end

  # Validations

  it { is_expected.to be_valid }

  describe "without an associated performance" do
    before { appearance.performance = nil }
    it { is_expected.not_to be_valid }
  end

  describe "without an associated participant" do
    before { appearance.participant = nil }
    it { is_expected.not_to be_valid }
  end

  describe "without an associated instrument" do
    before { appearance.instrument = nil }
    it { is_expected.not_to be_valid }
  end

  describe "without a participant role" do
    before { appearance.participant_role = nil }
    it { is_expected.not_to be_valid }
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

    it "should tell that it's a solo appearance" do
      expect(appearance.solo?).to be_truthy
    end

    it "should tell that it's not an ensemble appearance" do
      expect(appearance.ensemble?).to be_falsy
    end

    it "should tell that it's not an accompaniment appearance" do
      expect(appearance.accompaniment?).to be_falsy
    end
  end

  describe "with an ensemblist" do
    before { appearance.participant_role = 'ensemblist' }

    it "should tell that it's not a solo appearance" do
      expect(appearance.solo?).to be_falsy
    end

    it "should tell that it's an ensemble appearance" do
      expect(appearance.ensemble?).to be_truthy
    end

    it "should tell that it's not an accompaniment appearance" do
      expect(appearance.accompaniment?).to be_falsy
    end
  end

  describe "with an accompanist" do
    before { appearance.participant_role = 'accompanist' }

    it "should tell that it's not a solo appearance" do
      expect(appearance.solo?).to be_falsy
    end

    it "should tell that it's not an ensemble appearance" do
      expect(appearance.ensemble?).to be_falsy
    end

    it "should tell that it's an accompaniment appearance" do
      expect(appearance.accompaniment?).to be_truthy
    end
  end
end
