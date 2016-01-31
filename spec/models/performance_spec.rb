require 'rails_helper'

RSpec.describe Performance, type: :model do

  let (:performance) { build(:performance) }

  subject { performance }

  it { should respond_to(:contest_category) }
  it { should respond_to(:predecessor) }
  it { should respond_to(:appearances) }
  it { should respond_to(:participants) }
  it { should respond_to(:pieces) }

  it { should be_valid }

  describe "without an associated contest category" do
    before { performance.contest_category = nil }
    it { should_not be_valid }
  end

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

    it "finds all its participants" do
      performance = create(:performance, appearances: [@a1, @a2])
      expect(performance.participants).to eq([@a1.participant, @a2.participant])
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
end
