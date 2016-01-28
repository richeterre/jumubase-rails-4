require 'rails_helper'

RSpec.describe Instrument, type: :model do
  let (:instrument) { build(:instrument) }

  subject { instrument }

  it { should be_valid }

  describe "without a name" do
    before { instrument.name = nil }
    it { should_not be_valid }
  end
end
