require 'rails_helper'

RSpec.describe "Administrators", type: :request do
  before do
    user = create(:user, role: 0)
    sign_in user
  end

  describe "GET /index" do
    it 'renders a successful response' do
      get dashboard_path
      expect(response).to be_successful
    end
  end
end
