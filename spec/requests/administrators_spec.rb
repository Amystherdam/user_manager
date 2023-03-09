require 'rails_helper'

RSpec.describe "Administrators", type: :request do
  let(:administrator) { create(:user, role: 0) }
  let(:common_user) { create(:user) }

  let(:valid_attributes) do
    {
      full_name: 'User',
      email: 'user@user.com',
      password: '12345678',
      password_confirmation: '12345678'
    }
  end

  let(:invalid_attributes) do
    {
      full_name: nil,
      email: nil,
      password: nil,
      password_confirmation: nil
    }
  end

  describe "GET /index" do
    it 'renders a successful response' do
      sign_in administrator
      get dashboard_path
      expect(response).to have_http_status(:success)
    end

    it 'returns forbidden access' do
      sign_in common_user
      get dashboard_path
      expect(response).to have_http_status(:forbidden)
    end
  end

  describe "GET /new" do
    it 'renders a successful response' do
      sign_in administrator
      get new_user_administration_path
      expect(response).to have_http_status(:success)
    end

    it 'returns forbidden access' do
      sign_in common_user
      get new_user_administration_path
      expect(response).to have_http_status(:forbidden)
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new User' do
        sign_in administrator
        expect do
          post user_create_path, params: { user: valid_attributes }
        end.to change(User, :count).by(1)
      end

      it 'redirect to dashboard if successful' do
        sign_in administrator
        post user_create_path, params: { user: valid_attributes }
        expect(response).to have_http_status(:found)
        expect(response).to redirect_to(dashboard_path)
      end
    end

    context 'with valid parameters' do
      it 'no creates a new User' do
        sign_in administrator
        expect do
          post user_create_path, params: { user: invalid_attributes }
        end.to change(User, :count).by(0)
      end

      it 'renders the page itself if unsuccessful' do
        sign_in administrator
        post user_create_path, params: { user: invalid_attributes }
        expect(response).to render_template('administrators/new')
      end
    end
  end

  describe "GET /edit" do
    it 'renders a successful response' do
      sign_in administrator
      get edit_user_administration_path(common_user)
      expect(response).to have_http_status(:success)
    end

    it 'returns forbidden access' do
      sign_in common_user
      get edit_user_administration_path(administrator)
      expect(response).to have_http_status(:forbidden)
    end
    
    it 'renders a edit template' do
      sign_in administrator
      get edit_user_administration_path(common_user)
      expect(response).to render_template('devise/registrations/edit')
    end

    it 'renders a not authorized template' do
      sign_in common_user
      get edit_user_administration_path(administrator)
      expect(response).to render_template('errors/not_authorized')
    end
  end
end
