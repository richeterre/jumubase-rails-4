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

  it { should respond_to(:contest) }
  it { should respond_to(:category) }
  it { should respond_to(:performances) }

  it { should be_valid }
end
