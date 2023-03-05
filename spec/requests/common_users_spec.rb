require 'rails_helper'

RSpec.describe "CommonUsers", type: :request do
  before do
    user = create(:user)
    sign_in user
  end

  describe "GET /index" do
    it 'renders a successful response' do
      get profile_path
      expect(response).to be_successful
    end
  end
end
