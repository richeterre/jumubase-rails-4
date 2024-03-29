# == Schema Information
#
# Table name: contest_categories
#
#  id          :integer          not null, primary key
#  contest_id  :integer          not null
#  category_id :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe ContestCategory, type: :model do

  let (:contest_category) { build(:contest_category) }

  subject { contest_category }

  # Associations

  it { is_expected.to respond_to(:contest) }
  it { is_expected.to respond_to(:category) }
  it { is_expected.to respond_to(:performances) }

  it "should destroy its associated performances" do
    contest_category = create(:contest_category, performances: build_list(:performance, 3))
    expect { contest_category.destroy }.to change(Performance, :count).by(-3)
  end

  # Validations

  it { is_expected.to be_valid }

  describe "without a contest" do
    before { contest_category.contest = nil }
    it { is_expected.not_to be_valid }
  end

  describe "without a category" do
    before { contest_category.category = nil }
    it { is_expected.not_to be_valid }
  end
end
