require 'rails_helper'

RSpec.describe RoleHelper, type: :helper do
  describe '#path_by_role' do
    context 'when user is an administrator' do
      let(:administrator) { create(:user, role: 0) }

      before do
        allow(helper).to receive(:current_user).and_return(administrator)
      end

      it 'returns the dashboard path' do
        expect(helper.path_by_role).to eq(dashboard_path)
      end
    end

    context 'when user is an common user' do
      let(:common_user) { create(:user) }

      before do
        allow(helper).to receive(:current_user).and_return(common_user)
      end

      it 'returns the dashboard path' do
        expect(helper.path_by_role).to eq(profile_path)
      end
    end
  end
end
