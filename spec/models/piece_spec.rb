# == Schema Information
#
# Table name: pieces
#
#  id             :integer          not null, primary key
#  performance_id :integer          not null
#  title          :string           not null
#  composer_name  :string           not null
#  composer_born  :string
#  composer_died  :string
#  epoch          :string           not null
#  minutes        :integer          not null
#  seconds        :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'rails_helper'

RSpec.describe Piece, type: :model do

  let (:piece) { build(:piece) }

  subject { piece }

  it { is_expected.to be_valid }

  describe "without an associated performance" do
    before { piece.performance = nil }
    it { is_expected.not_to be_valid }
  end

  describe "without a title" do
    before { piece.title = nil }
    it { is_expected.not_to be_valid }
  end

  describe "without a composer name" do
    before { piece.composer_name = nil }
    it { is_expected.not_to be_valid }
  end

  describe "without an epoch" do
    before { piece.epoch = nil }
    it { is_expected.not_to be_valid }
  end

  describe "with an invalid epoch" do
    it "should not be valid" do
      [1, 'g', ' ', '-'].each do |invalid_value|
        piece.epoch = invalid_value
        expect(piece).not_to be_valid
      end
    end
  end

  describe "without a minutes value" do
    before { piece.minutes = nil }
    it { is_expected.not_to be_valid }
  end

  describe "without a seconds value" do
    before { piece.seconds = nil }
    it { is_expected.not_to be_valid }
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
