RSpec.describe CategoryPolicy do

  describe "action" do

    subject { CategoryPolicy }

    let (:host) { Host.new }

    permissions :index? do
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
    let (:scope) { Category.all }

    let (:categories) { create_list(:category, 3) }

    subject (:policy_scope) { ContestPolicy::Scope.new(user, scope).resolve }

    context "for regular users" do
      let (:user) { build(:user) }

      it "shows no categories" do
        expect(policy_scope).to eq []
      end
    end

    context "for inspectors" do
      let (:user) { build(:inspector) }

      it "shows no categories" do
        expect(policy_scope).to eq []
      end
    end

    context "for admins" do
      let (:user) { build(:admin) }

      it "shows all categories" do
        expect(policy_scope).to eq categories
      end
    end
  end
end
