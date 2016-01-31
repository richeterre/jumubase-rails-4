RSpec.describe ContestCategoryPolicy do

  describe ".scope" do
    subject (:policy_scope) { ContestCategoryPolicy::Scope.new(user, scope).resolve }

    let (:host) { create(:host) }
    let (:user) { User.new(hosts: [host]) }
    let (:scope) { ContestCategory.all }

    it "hides contest categories whose contest host is not among the user's hosts" do
      # Contest and contest category "owned" by the user
      own_contest = create(:contest, host: host)
      own_contest_cat = create(:contest_category, contest: own_contest)

      # "Foreign" contest and contest category
      foreign_contest = create(:contest)
      foreign_contest_cat = create(:contest_category, contest: foreign_contest)

      expect(policy_scope).to eq [own_contest_cat]
    end
  end
end
