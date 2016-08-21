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
#  first_name             :string           not null
#  last_name              :string           not null
#

require 'rails_helper'

RSpec.describe User, type: :model do

  let (:user) { build(:user) }

  subject { user }

  # Associations

  it { should respond_to(:first_name) }
  it { should respond_to(:last_name) }

  # Validations

  it { should be_valid }

  describe "without a first name" do
    before { user.first_name = nil }
    it { should_not be_valid }
  end

  describe "without a last name" do
    before { user.last_name = nil }
    it { should_not be_valid }
  end

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

  # Helpers

  it "should provide a full name" do
    user = build(:user, first_name: "A", last_name: "B")
    expect(user.full_name).to eq("A B")
  end

  it "should tell whether it has an admin role" do
    expect(build(:user).admin?).to be_falsey
    expect(build(:inspector).admin?).to be_falsey
    expect(build(:admin).admin?).to be_truthy
  end

  it "should tell whether it has an inspector role" do
    expect(build(:user).inspector?).to be_falsey
    expect(build(:inspector).inspector?).to be_truthy
    expect(build(:admin).inspector?).to be_falsey
  end
end
