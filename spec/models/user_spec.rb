require 'rails_helper'

RSpec.describe User, type: :model do

  let (:user) { build(:user) }

  subject { user }

  it { should be_valid }

  describe "without a role" do
    before { user.role = nil }
    it { should_not be_valid }
  end

  describe "with an invalid role" do
    it "should not be valid" do
      ['', 'marauder'].each do |invalid_role|
        user.role = invalid_role
        expect(user).not_to be_valid
      end
    end
  end

  describe "with a valid role" do
    it "should be valid" do
      JUMU_USER_ROLES.each do |valid_role|
        user.role = valid_role
        expect(user).to be_valid
      end
    end
  end

  it "tells whether it has a given role" do
    user = build(:user, role: "admin")
    expect(user.has_role?(:admin)).to be_truthy
    expect(user.has_role?(:regular)).to be_falsey
  end
end
