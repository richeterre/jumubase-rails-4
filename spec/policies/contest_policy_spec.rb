RSpec.describe ContestPolicy do

  describe "action" do

    subject { ContestPolicy }

    let (:host) { Host.new }

    permissions :show? do
      context "for regular users" do
        it "denies access if host is not among the user's hosts" do
          expect(subject).not_to permit(build(:user, hosts: []), Contest.new(host: host))
        end

        it "grants access if host is among the user's hosts" do
          expect(subject).to permit(build(:user, hosts: [host]), Contest.new(host: host))
        end
      end

      it "grants access to inspectors" do
        expect(subject).to permit(build(:inspector), Contest.new)
      end
    end

    permissions :create? do
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

    permissions :index_performances? do
      context "for regular users" do
        it "denies access if host is not among the user's hosts" do
          expect(subject).not_to permit(build(:user, hosts: []), Contest.new(host: host))
        end

        it "grants access if host is among the user's hosts" do
          expect(subject).to permit(build(:user, hosts: [host]), Contest.new(host: host))
        end
      end

      it "grants access to inspectors" do
        expect(subject).to permit(build(:inspector), Contest.new)
      end

      it "grants access to admins" do
        expect(subject).to permit(build(:admin), Contest.new)
      end
    end
  end

  describe "scope" do
    let (:host) { create(:host) }
    let (:scope) { Contest.all }

    let (:contest1) { create(:contest, host: host) } # "own" contest
    let (:contest2) { create(:contest) } # "foreign" contest
    let (:contest3) { create(:contest, host: host) } # "own" contest

    subject (:policy_scope) { ContestPolicy::Scope.new(user, scope).resolve }

    context "for regular users" do
      let (:user) { build(:user, hosts: [host]) }

      it "hides contests whose host is not among the user's hosts" do
        expect(policy_scope).to eq [contest1, contest3]
      end
    end

    context "for inspectors" do
      let (:user) { build(:inspector) }

      it "shows all contests" do
        expect(policy_scope).to eq [contest1, contest2, contest3]
      end
    end

    context "for admins" do
      let (:user) { build(:admin) }

      it "shows all contests" do
        expect(policy_scope).to eq [contest1, contest2, contest3]
      end
    end
  end
end
