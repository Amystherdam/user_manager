require 'rails_helper'

RSpec.describe "Administrators", type: :request do
  before do
    @user = create(:user, role: 0)
    sign_in @user
  end

  describe "GET /index" do
    it 'renders a successful response' do
      get dashboard_path
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it 'renders a successful response' do
      get edit_user_administration_path(@user)
      expect(response).to be_successful
    end

    it 'renders a edit template' do
      get edit_user_administration_path(@user)
      expect(response).to render_template('devise/registrations/edit')
    end
  end
end
