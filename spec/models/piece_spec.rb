require 'rails_helper'

RSpec.describe Piece, type: :model do

  let (:piece) { build(:piece) }

  subject { piece }

  it { should be_valid }

  describe "without an associated performance" do
    before { piece.performance = nil }
    it { should_not be_valid }
  end

  describe "without a title" do
    before { piece.title = nil }
    it { should_not be_valid }
  end

  describe "without a composer name" do
    before { piece.composer_name = nil }
    it { should_not be_valid }
  end

  describe "without an epoch" do
    before { piece.epoch = nil }
    it { should_not be_valid }
  end

  describe "without a minutes value" do
    before { piece.minutes = nil }
    it { should_not be_valid }
  end

  describe "without a seconds value" do
    before { piece.seconds = nil }
    it { should_not be_valid }
  end

  describe "with invalid minutes" do
    it "should not be valid" do
      [-1, 0.5, 60].each do |invalid_value|
        piece.minutes = invalid_value
        expect(piece).not_to be_valid
      end
    end
  end

  describe "with invalid seconds" do
    it "should not be valid" do
      [-1, 0.5, 60].each do |invalid_value|
        piece.seconds = invalid_value
        expect(piece).not_to be_valid
      end
    end
  end
end
