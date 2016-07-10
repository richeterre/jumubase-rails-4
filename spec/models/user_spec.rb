# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  role                   :string           not null
#

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
    user = build(:user, role: 'admin')
    expect(user.has_role?(:admin)).to be_truthy
    expect(user.has_role?(:regular)).to be_falsey
  end

  it "tells whether it has an admin role" do
    regular_user = build(:user, role: 'regular')
    admin_user = build(:user, role: 'admin')
    expect(regular_user.admin?).to be_falsey
    expect(admin_user.admin?).to be_truthy
  end
end
