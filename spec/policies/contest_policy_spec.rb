RSpec.describe ContestPolicy do

  permissions :show? do
    subject { ContestPolicy }

    let (:host) { Host.new }

    it "denies access if host is not among the user's hosts" do
      expect(subject).not_to permit(User.new(hosts: []), Contest.new(host: host))
    end

    it "grants access if host is among the user's hosts" do
      expect(subject).to permit(User.new(hosts: [host]), Contest.new(host: host))
    end
  end

  permissions :index do
    subject (:policy_scope) { ContestPolicy::Scope.new(user, scope).resolve }

    let (:host) { create(:host) }
    let (:user) { User.new(hosts: [host]) }
    let (:scope) { Contest.all }

    it "hides contests whose host is not among the user's hosts" do
      own_contest_1 = create(:contest, host: host)
      foreign_contest = create(:contest)
      own_contest_2 = create(:contest, host: host)

      expect(policy_scope).to eq [own_contest_1, own_contest_2]
    end
  end
end