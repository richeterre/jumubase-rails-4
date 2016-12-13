RSpec.describe PerformancePolicy do

  subject { described_class.new(user, performance) }

  let (:resolved_scope) do
    described_class::Scope.new(user, Performance.all).resolve
  end

  let (:host) { create(:host) }

  let! (:performance) do
    contest_category = create(:contest_category, contest: create(:contest, host: host))
    create(:performance, contest_category: contest_category)
  end

  let! (:foreign_performance) { create(:performance) }
  let! (:successor_performance) { create(:performance, predecessor: performance) }

  context "for regular users" do
    let (:user) { build(:user) }

    it { is_expected.to forbid_action(:show) }

    describe "associated with the performance's contest host" do
      let (:user) { build(:user, hosts: [host]) }
      it { is_expected.to permit_action(:show) }

      it "should list only performances whose contest or predecessor's contest have a host associated with the user" do
        expect(resolved_scope).to match_array [performance, successor_performance]
      end
    end
  end

  context "for inspectors" do
    let (:user) { build(:inspector) }

    it { is_expected.to permit_action(:show) }

    it "should list all performances" do
      expect(resolved_scope).to match_array [performance, foreign_performance, successor_performance]
    end
  end

  context "for admins" do
    let (:user) { build(:admin) }

    it { is_expected.to permit_action(:show) }

    it "should list all performances" do
      expect(resolved_scope).to match_array [performance, foreign_performance, successor_performance]
    end
  end
end
