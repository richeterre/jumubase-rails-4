RSpec.describe ContestCategoryPolicy do

  subject { described_class.new(user, contest_category) }

  let (:resolved_scope) do
    described_class::Scope.new(user, ContestCategory.all).resolve
  end

  let (:host) { build(:host) }

  # Create primary contest category within one of the user's contests
  let (:user_contest) { create(:contest, host: host) }
  let! (:contest_category) { create(:contest_category, contest: user_contest) }

  # Create another contest category that's not in the user's contests
  let (:foreign_contest) { create(:contest) }
  let! (:foreign_contest_category) { create(:contest_category, contest: foreign_contest) }

  context "for regular users" do
    let (:user) { build(:user, hosts: [host]) }

    it { is_expected.to forbid_action(:destroy) }

    it "should list only contest categories from user's own contests" do
      expect(resolved_scope).to match_array [contest_category]
    end
  end

  context "for inspectors" do
    let (:user) { build(:inspector) }

    it { is_expected.to forbid_action(:destroy) }

    it "should list all contest categories" do
      expect(resolved_scope).to match_array [contest_category, foreign_contest_category]
    end
  end

  context "for admins" do
    let (:user) { build(:admin) }

    it { is_expected.to permit_action(:destroy) }

    it "should list all contest categories" do
      expect(resolved_scope).to match_array [contest_category, foreign_contest_category]
    end
  end
end
