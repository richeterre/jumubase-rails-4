RSpec.describe ContestCategoryPolicy do

  describe "action" do

    subject { ContestCategoryPolicy }

    permissions :destroy? do
      it "is denied for regular users" do
        expect(subject).not_to permit(build(:user), Contest)
      end

      it "is denied for inspectors" do
        expect(subject).not_to permit(build(:inspector), Contest)
      end

      it "is allowed for admins" do
        expect(subject).to permit(build(:admin), Contest)
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
