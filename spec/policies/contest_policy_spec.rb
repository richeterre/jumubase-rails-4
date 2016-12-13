RSpec.describe ContestPolicy do

  subject { described_class.new(user, contest) }

  let (:resolved_scope) do
    described_class::Scope.new(user, Contest.all).resolve
  end

  let (:host) { build(:host) }

  # Create two contests, one being associated with the user
  let! (:contest) { create(:contest, host: host) }
  let! (:foreign_contest) { create(:contest) }

  context "for regular users" do
    let (:user) { build(:user) }

    it { is_expected.to forbid_action(:create) }
    it { is_expected.to forbid_action(:update) }
    it { is_expected.to forbid_action(:index_contest_categories) }

    describe "not associated with the contest's host" do
      it { is_expected.to forbid_action(:show) }
      it { is_expected.to forbid_action(:index_performances) }
    end

    describe "associated with the contest's host" do
      let (:user) { build(:user, hosts: [host]) }

      it { is_expected.to permit_action(:show) }
      it { is_expected.to permit_action(:index_performances) }

      it "should list only contests whose host is associated with the user" do
        expect(resolved_scope).to match_array [contest]
      end
    end
  end

  context "for inspectors" do
    let (:user) { build(:inspector) }

    it { is_expected.to forbid_action(:create) }
    it { is_expected.to forbid_action(:update) }
    it { is_expected.to forbid_action(:index_contest_categories) }

    it { is_expected.to permit_action(:show) }

    it "should list all contests" do
      expect(resolved_scope).to match_array [contest, foreign_contest]
    end
  end

  context "for admins" do
    let (:user) { build(:admin) }

    it { is_expected.to permit_action(:create) }
    it { is_expected.to permit_action(:update) }
    it { is_expected.to permit_action(:index_contest_categories) }

    it { is_expected.to permit_action(:show) }

    it "should list all contests" do
      expect(resolved_scope).to match_array [contest, foreign_contest]
    end
  end
end
