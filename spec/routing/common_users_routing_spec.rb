require 'rails_helper'

RSpec.describe CommonUsersController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/profile').to route_to('common_users#index')
    end
  end
end
