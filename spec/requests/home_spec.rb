require 'rails_helper'

RSpec.describe "Home", type: :request do
  before do
    @common_user = create(:user)
    @administrator = create(:user, role: 0)
  end

  describe "GET /" do
    it "common user makes" do
      sign_in @common_user
      get root_path
      expect(response).to redirect_to(profile_path)
    end

    it "administrator makes" do
      sign_in @administrator
      get root_path
      expect(response).to redirect_to(dashboard_path)
    end
  end
end
