RSpec.describe PerformancePolicy do

  permissions :show? do
    subject { PerformancePolicy }

    let (:host) { Host.new }
    let (:performance) do
      contest_category = ContestCategory.new(contest: Contest.new(host: host))
      Performance.new(contest_category: contest_category)
    end

    it "denies access if contest host is not among the user's hosts" do
      expect(subject).not_to permit(User.new(hosts: []), performance)
    end

    it "grants access if contest host is among the user's hosts" do
      expect(subject).to permit(User.new(hosts: [host]), performance)
    end
  end

  permissions :index do
    subject (:policy_scope) { PerformancePolicy::Scope.new(user, scope).resolve }

    let (:host) { create(:host) }
    let (:user) { User.new(hosts: [host]) }
    let (:scope) { Performance.all }

    it "hides performances whose contest host or predecessor's contest host is not among the user's hosts" do
      # Contest and performance "owned" by the user
      own_contest = create(:contest, host: host)
      own_contest_cat = create(:contest_category, contest: own_contest)
      own_perf = Performance.create(contest_category: own_contest_cat)

      # "Foreign" contest and performance
      foreign_contest = create(:contest)
      foreign_contest_cat = create(:contest_category, contest: foreign_contest)
      foreign_perf = Performance.create(contest_category: foreign_contest_cat)

      # Performance in foreign contest, but with predecessor owned by user
      own_pred_perf = Performance.create(
        contest_category: foreign_contest_cat,
        predecessor: own_perf
      )

      expect(policy_scope).to eq [own_perf, own_pred_perf]
    end
  end
end
