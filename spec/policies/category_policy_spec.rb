RSpec.describe CategoryPolicy do

  subject { described_class.new(user, category) }

  let (:resolved_scope) do
    described_class::Scope.new(user, Category.all).resolve
  end

  let! (:category) { create(:category) }

  context "for regular users" do
    let (:user) { build(:user) }

    it { is_expected.to forbid_action(:index) }

    it "doesn't list any categories" do
      expect(resolved_scope).to match_array []
    end
  end

  context "for inspectors" do
    let (:user) { build(:inspector) }

    it { is_expected.to forbid_action(:index) }

    it "doesn't list any categories" do
      expect(resolved_scope).to match_array []
    end
  end

  context "for admins" do
    let (:user) { build(:admin) }

    it { is_expected.to permit_action(:index) }

    it "lists all categories" do
      expect(resolved_scope).to match_array [category]
    end
  end
end
