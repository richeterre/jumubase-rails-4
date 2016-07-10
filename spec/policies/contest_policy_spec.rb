RSpec.describe ContestPolicy do

  describe "action" do

    subject { ContestPolicy }

    let (:host) { Host.new }

    permissions :show? do
      it "denies access if host is not among the user's hosts" do
        expect(subject).not_to permit(build(:user, hosts: []), Contest.new(host: host))
      end

      it "grants access if host is among the user's hosts" do
        expect(subject).to permit(build(:user, hosts: [host]), Contest.new(host: host))
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
