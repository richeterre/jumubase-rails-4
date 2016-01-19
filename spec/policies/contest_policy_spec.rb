RSpec.describe ContestPolicy do
  subject { ContestPolicy }

  permissions :show? do
    it "denies access if host is not among the user's hosts" do
      host = Host.new
      expect(subject).not_to permit(User.new(hosts: []), Contest.new(host: host))
    end

    it "grants access if host is among the user's hosts" do
      host = Host.new
      expect(subject).to permit(User.new(hosts: [host]), Contest.new(host: host))
    end
  end
end
