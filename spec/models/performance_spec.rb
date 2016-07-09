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
#

require 'rails_helper'

RSpec.describe Performance, type: :model do

  let (:performance) { build(:performance) }

  subject { performance }

  # Associations

  it { should respond_to(:contest_category) }
  it { should respond_to(:predecessor) }
  it { should respond_to(:appearances) }
  it { should respond_to(:pieces) }
  it { should respond_to(:contest) }
  it { should respond_to(:category) }
  it { should respond_to(:stage_time) }

  it "finds its predecessor, if present" do
    predecessor = create(:performance)
    performance = create(:performance, predecessor_id: predecessor.id)
    expect(performance.predecessor).to eq(predecessor)
  end

  describe "with multiple appearances" do
    before do
      @a1 = build(:appearance, participant_role: 'soloist')
      @a2 = build(:appearance, participant_role: 'accompanist')
    end

    it "destroys any dependent appearances" do
      performance = create(:performance, appearances: [@a1, @a2])
      expect {
        performance.destroy
      }.to change(Appearance, :count).by(-2)
    end
  end

  it "destroys any dependent pieces" do
    p1 = build(:piece)
    p2 = build(:piece)
    performance = create(:performance, pieces: [p1, p2])
    expect {
      performance.destroy
    }.to change(Piece, :count).by(-2)
  end

  # Validations

  it { should be_valid }

  describe "without an associated contest category" do
    before { performance.contest_category = nil }
    it { should_not be_valid }
  end

  describe "without at least one associated appearance" do
    before { performance.appearances = [] }
    it { should_not be_valid }
  end

  describe "with multiple soloist appearances" do
    before do
      performance.appearances = [
        build(:appearance, participant_role: 'soloist'),
        build(:appearance, participant_role: 'soloist')
      ]
    end
    it { should_not be_valid }
  end

  describe "with only accompanist appearances" do
    before do
      performance.appearances = [
        build(:appearance, participant_role: 'accompanist'),
        build(:appearance, participant_role: 'accompanist')
      ]
    end
    it { should_not be_valid }
  end

  describe "with a single ensemblist appearance" do
    before do
      performance.appearances = [
        build(:appearance, participant_role: 'ensemblist')
      ]
    end
    it { should_not be_valid }
  end

  describe "with both soloist and ensemblist appearances" do
    before do
      performance.appearances = [
        build(:appearance, participant_role: 'soloist'),
        build(:appearance, participant_role: 'ensemblist')
      ]
    end
    it { should_not be_valid }
  end
end
