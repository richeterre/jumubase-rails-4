require 'rails_helper'

RSpec.describe ContestCategory, type: :model do

  let (:contest_category) { build(:contest_category) }

  subject { contest_category }

  it { should respond_to(:contest) }
  it { should respond_to(:category) }
  it { should respond_to(:performances) }

  it { should be_valid }
end
