RSpec.describe ContestCategoryPolicy do

  describe "action" do

    subject { ContestCategoryPolicy }

    permissions :destroy? do
      it "denies access to regular users" do
        expect(subject).not_to permit(build(:user))
      end

      it "denies access to inspectors" do
        expect(subject).not_to permit(build(:inspector))
      end

      it "grants access to admins" do
        expect(subject).to permit(build(:admin))
      end
    end
  end

  describe "scope" do
    subject (:policy_scope) { ContestCategoryPolicy::Scope.new(user, scope).resolve }

    let (:scope) { ContestCategory.all }
    let (:host) { create(:host) }

    # Contest and contest category "owned" by the user
    let! (:own_contest) { create(:contest, host: host) }
    let! (:own_contest_cat) { create(:contest_category, contest: own_contest) }

    # "Foreign" contest and contest category
    let! (:foreign_contest) { create(:contest) }
    let! (:foreign_contest_cat) { create(:contest_category, contest: foreign_contest) }

    context "for regular users" do
      let (:user) { User.new(hosts: [host]) }

      it "hides contest categories whose contest host is not among the user's hosts" do
        expect(policy_scope).to eq [own_contest_cat]
      end
    end

    context "for inspectors" do
      let (:user) { build(:inspector) }

      it "shows all contest categories" do
        expect(policy_scope).to eq [own_contest_cat, foreign_contest_cat]
      end
    end

    context "for admins" do
      let (:user) { build(:admin) }

      it "shows all contest categories" do
        expect(policy_scope).to eq [own_contest_cat, foreign_contest_cat]
      end
    end
  end
end
