RSpec.describe PerformancePolicy do

  describe "action" do
    permissions :show? do
      subject { PerformancePolicy }

      context "for regular users" do
        let (:host) { Host.new }
        let (:performance) do
          contest_category = ContestCategory.new(contest: Contest.new(host: host))
          Performance.new(contest_category: contest_category)
        end

        it "denies access if contest host is not among the user's hosts" do
          expect(subject).not_to permit(build(:user, hosts: []), performance)
        end

        it "grants access if contest host is among the user's hosts" do
          expect(subject).to permit(build(:user, hosts: [host]), performance)
        end
      end

      it "grants access to inspectors" do
        expect(subject).to permit(build(:inspector), build(:performance))
      end

      it "grants access to admins" do
        expect(subject).to permit(build(:admin), build(:performance))
      end
    end
  end

  describe "scope" do
    subject (:policy_scope) { PerformancePolicy::Scope.new(user, scope).resolve }

    let (:scope) { Performance.all }
    let (:host) { create(:host) }

    # Contest and performance associated with the host
    let ( :contest1 ) { create(:contest, host: host) }
    let ( :contest1_cat ) { create(:contest_category, contest: contest1) }
    let ( :performance1 ) { create(:performance, contest_category: contest1_cat) }

    # "Foreign" contest and performance
    let ( :contest2 ) { create(:contest) }
    let ( :contest2_cat ) { create(:contest_category, contest: contest2) }
    let ( :performance2 ) { create(:performance, contest_category: contest2_cat) }

    # Performance in foreign contest, but with predecessor in host's own contest
    let ( :performance3 ) do
      create(:performance, contest_category: contest2_cat, predecessor: performance1)
    end

    context "for regular users" do
      let (:user) { User.new(hosts: [host]) }

      it "hides performances whose contest host or predecessor's contest host is not among the user's hosts" do
        expect(policy_scope).to eq [performance1, performance3]
      end
    end

    context "for inspectors" do
      let (:user) { build(:inspector) }

      it "shows all performances" do
        expect(policy_scope).to eq [performance1, performance2, performance3]
      end
    end

    context "for admins" do
      let (:user) { build(:admin) }

      it "shows all performances" do
        expect(policy_scope).to eq [performance1, performance2, performance3]
      end
    end
  end
end
