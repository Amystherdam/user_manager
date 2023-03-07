require 'rails_helper'

RSpec.describe RegistrationsController, type: :request do
  let(:administrator) { create(:user, role: 0) }
  let(:affected_user) { create(:user) }
  let(:other_user) { create(:user) }

  before do
    @affected_user = create(:user)
    @administrator = create(:user, role: 0)
  end

  describe 'PATCH /update' do
    context 'not user account owner' do
      let(:new_attributes) do
        { id: affected_user.id, full_name: 'New User Name' }
      end

      context 'user is administrator' do
        it 'should update the requested user' do
          sign_in administrator
          patch user_registration_path(affected_user), params: { user: new_attributes }
          affected_user.reload
          expect(affected_user.full_name).to eq(new_attributes[:full_name])
        end

        it 'should redirect if successful' do
          sign_in administrator
          patch user_registration_path(affected_user), params: { user: new_attributes }

          expect(response).to have_http_status(:found)
          expect(response).to redirect_to(dashboard_path)
        end
      end

      context 'user is common' do
        it 'should not update requested user' do
          sign_in other_user
          patch user_registration_path(affected_user), params: { user: new_attributes }
          affected_user.reload
          expect(affected_user.full_name).to eq('User')
        end

        it 'should redirect if not run' do
          sign_in other_user
          patch user_registration_path(affected_user), params: { user: new_attributes }

          expect(response).to have_http_status(:found)
          expect(response).to redirect_to(profile_path)
        end
      end
    end

    context 'user account owner' do      
      context 'user is administrator' do
        let(:new_attributes) do
          { id: administrator.id, full_name: 'New User Name' }
        end

        it 'should update the requested user' do
          sign_in administrator
          patch user_registration_path(administrator), params: { user: new_attributes }
          administrator.reload

          expect(administrator.full_name).to eq(new_attributes[:full_name])
        end

        it 'should redirect if successful' do
          sign_in administrator
          patch user_registration_path(administrator), params: { user: new_attributes }

          expect(response).to have_http_status(:found)
          expect(response).to redirect_to(dashboard_path)
        end
      end

      context 'user is common' do
        let(:new_attributes) do
          { id: affected_user.id, full_name: 'New User Name', current_password: '12345678' }
        end

        it 'should update requested user' do
          sign_in affected_user
          patch user_registration_path(affected_user, format: :html), params: { user: new_attributes }
          affected_user.reload

          expect(affected_user.full_name).to eq('New User Name')
        end

        it 'should redirect if successful' do
          sign_in affected_user
          patch user_registration_path(affected_user, format: :html), params: { user: new_attributes }

          expect(response).to have_http_status(:see_other)
          expect(response).to redirect_to(profile_path)
        end
      end
    end
  end

  describe "DELETE /destroy" do
    context 'not user account owner' do
      context 'user is administrator' do
        it "should destroy requested user" do
          sign_in administrator
          expect {
            delete user_registration_path(user_id: @affected_user.id)
          }.to change(User, :count).by(-1)
        end

        it "should redirect if successful" do
          sign_in administrator
          delete user_registration_path(user_id: @affected_user.id)

          expect(response).to have_http_status(:found)
          expect(response).to redirect_to(dashboard_path)
        end
      end

      context 'user is common' do
        it "should not destroy requested user" do
          sign_in other_user
          expect {
            delete user_registration_path(user_id: @affected_user.id)
          }.to change(User, :count).by(0)
        end

        it "should redirect if not run" do
          sign_in other_user
          delete user_registration_path(user_id: @affected_user.id)

          expect(response).to have_http_status(:found)
          expect(response).to redirect_to(profile_path)
        end
      end
    end

    context 'user account owner' do      
      context 'user is administrator' do
        it 'should destroy requested user' do
          sign_in @administrator
          expect {
            delete user_registration_path(user_id: @administrator.id)
          }.to change(User, :count).by(-1)
        end

        it 'should be logged out after deleting own account' do
          sign_in @administrator
          delete user_registration_path(user_id: @administrator.id)

          expect(controller).not_to be_signed_in
        end
      end

      context 'user is common' do
        it 'should destroy requested user' do
          sign_in @affected_user
          expect {
            delete user_registration_path(user_id: @affected_user.id)
          }.to change(User, :count).by(-1)
        end

        it 'should be logged out after deleting own account' do
          sign_in @affected_user
          delete user_registration_path(user_id: @affected_user.id)

          expect(controller).not_to be_signed_in
        end
      end
    end
  end

end
