require 'rails_helper'

RSpec.describe AdministratorsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/dashboard').to route_to('administrators#index')
    end

    it 'routes to #edit' do
      expect(get: 'user/1/edit').to route_to('administrators#edit', id: '1')
    end
  end
end
