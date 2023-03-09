require 'rails_helper'

RSpec.describe UserPolicy, type: :policy do
  subject { UserPolicy }

  let(:admin) { create(:user, role: 0) }
  let(:common_user) { create(:user) }
  let(:record) { create(:user) }

  permissions :index? do
    it "allows access for admins" do
      expect(subject).to permit(admin)
    end

    it "denies access for common users" do
      expect(subject).not_to permit(common_user)
    end
  end

  permissions :update?, :edit?, :destroy? do
    it "allows access for admins" do
      expect(subject).to permit(admin, record)
    end

    it "allows access for the user who owns the record" do
      expect(subject).to permit(common_user, common_user)
    end

    it "denies access for common users who don't own the record" do
      expect(subject).not_to permit(common_user, record)
    end
  end

  permissions :new?, :create? do
    it "allows access for admins" do
      expect(subject).to permit(admin, record)
    end

    it "allows access for the user who owns the record" do
      expect(subject).not_to permit(common_user, record)
    end
  end
end
