# == Schema Information
#
# Table name: performances
#
#  id                  :integer          not null, primary key
#  predecessor_id      :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  contest_category_id :integer          not null
#  stage_time          :datetime
#  stage_venue_id      :integer
#  edit_code           :string           not null
#

require 'rails_helper'

RSpec.describe Performance, type: :model do

  let (:performance) { build(:performance) }

  subject { performance }

  # Associations

  it { is_expected.to respond_to(:contest_category) }
  it { is_expected.to respond_to(:predecessor) }
  it { is_expected.to respond_to(:stage_venue) }
  it { is_expected.to respond_to(:appearances) }
  it { is_expected.to respond_to(:pieces) }
  it { is_expected.to respond_to(:contest) }
  it { is_expected.to respond_to(:category) }
  it { is_expected.to respond_to(:stage_time) }
  it { is_expected.to respond_to(:edit_code) }

  it "should find its predecessor, if present" do
    predecessor = create(:performance)
    performance = create(:performance, predecessor_id: predecessor.id)
    expect(performance.predecessor).to eq(predecessor)
  end

  it "should find its stage venue, if present" do
    stage_venue = create(:venue)
    performance = create(:performance, stage_venue_id: stage_venue.id)
    expect(performance.stage_venue).to eq(stage_venue)
  end

  describe "with multiple appearances" do
    before do
      @a1 = build(:appearance, participant_role: 'soloist')
      @a2 = build(:appearance, participant_role: 'accompanist')
    end

    it "should destroy any dependent appearances" do
      performance = create(:performance, appearances: [@a1, @a2])
      expect {
        performance.destroy
      }.to change(Appearance, :count).by(-2)
    end
  end

  it "should destroy any dependent pieces" do
    p1 = build(:piece)
    p2 = build(:piece)
    performance = create(:performance, pieces: [p1, p2])
    expect {
      performance.destroy
    }.to change(Piece, :count).by(-2)
  end

  describe "when created with nested appearances" do
    let (:contest_category) { create(:contest_category) }
    let (:participants) { create_list(:participant, 2) }
    let (:instrument) { create(:instrument) }
    let (:params) do
      {
        contest_category_id: contest_category.id,
        appearances_attributes: [
          {
            participant_id: participants[0].id,
            instrument_id: instrument.id,
            participant_role: 'soloist'
          },
          {
            participant_id: participants[1].id,
            instrument_id: instrument.id,
            participant_role: 'accompanist'
          }
        ]
      }
    end

    subject { lambda { Performance.create(params) } }

    it { is_expected.to change(Performance, :count).by(1) }
    it { is_expected.to change(Appearance, :count).by(2) }
  end

  # Validations

  it { is_expected.to be_valid }

  describe "without an associated contest category" do
    before { performance.contest_category = nil }
    it { is_expected.not_to be_valid }
  end

  describe "without at least one associated appearance" do
    before { performance.appearances = [] }
    it { is_expected.not_to be_valid }
  end

  describe "with multiple soloist appearances" do
    before do
      performance.appearances = [
        build(:appearance, participant_role: 'soloist'),
        build(:appearance, participant_role: 'soloist')
      ]
    end
    it { is_expected.not_to be_valid }
  end

  describe "with only accompanist appearances" do
    before do
      performance.appearances = [
        build(:appearance, participant_role: 'accompanist'),
        build(:appearance, participant_role: 'accompanist')
      ]
    end
    it { is_expected.not_to be_valid }
  end

  describe "with a single ensemblist appearance" do
    before do
      performance.appearances = [
        build(:appearance, participant_role: 'ensemblist')
      ]
    end
    it { is_expected.not_to be_valid }
  end

  describe "with both soloist and ensemblist appearances" do
    before do
      performance.appearances = [
        build(:appearance, participant_role: 'soloist'),
        build(:appearance, participant_role: 'ensemblist')
      ]
    end
    it { is_expected.not_to be_valid }
  end

  describe "with the same participant appearing multiple times" do
    before do
      participant = build(:participant)
      performance.appearances = [
        build(:appearance, participant: participant, participant_role: 'soloist'),
        build(:appearance, participant: participant, participant_role: 'accompanist')
      ]
    end
    it { is_expected.not_to be_valid }
  end

  it "should not be valid with a non-unique edit code" do
    existing_performance = create(:performance)
    performance = create(:performance)

    # Now we can tweak the code, which is only generated before validation on create
    performance.edit_code = existing_performance.edit_code
    expect(performance).not_to be_valid
  end

  # Callbacks

  it "should add an edit code when validating on creation" do
    # This test replaces the "presence: true" validation test, which won't
    # work because the very act of validating makes the performance valid.
    performance = build(:performance)
    expect(performance.edit_code).to be_nil
    performance.valid?
    expect(performance.edit_code).not_to be_nil
  end

  it "should not add an edit code when validating later" do
    performance = create(:performance)
    edit_code = performance.edit_code

    expect {
      performance.valid?
    }.not_to change(performance, :edit_code)
  end
end
