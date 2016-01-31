require 'rails_helper'

RSpec.describe Category, type: :model do

  let (:category) { build(:category) }

  subject { category }

  it { should be_valid }

  describe "without a name" do
    before { category.name = nil }
    it { should_not be_valid }
  end

  describe "without a slug" do
    before { category.slug = nil }
    it { should_not be_valid }
  end

  describe "without a genre" do
    before { category.genre = nil }
    it { should_not be_valid }
  end

  describe "without a solo flag" do
    before { category.solo = nil }
    it { should_not be_valid }
  end

  describe "without an ensemble flag" do
    before { category.ensemble = nil }
    it { should_not be_valid }
  end
end
