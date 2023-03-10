require 'rails_helper'

RSpec.describe UserService do
  let(:user_service) { UserService.new }
  before do
    create(:user, role: 0)
    2.times { create(:user) }
  end

  it '#user_counts' do
    expect(user_service.user_counts).to eq({ all: 3, role_admin: 1, role_common: 2 })
  end
end
