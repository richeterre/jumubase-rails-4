require 'rails_helper'

RSpec.describe Performance, type: :model do

  let (:performance) { build(:performance) }

  subject { performance }

  it { should respond_to(:contest_category) }
  it { should respond_to(:predecessor) }

  it { should be_valid }

  describe "without an associated contest category" do
    before { performance.contest_category = nil }
    it { should_not be_valid }
  end

  it "finds its predecessor, if present" do
    predecessor = build(:performance)
    performance.predecessor = predecessor
    expect(performance.predecessor).to equal(predecessor)
  end
end
