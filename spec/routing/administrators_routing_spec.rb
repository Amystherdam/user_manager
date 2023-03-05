require 'rails_helper'

RSpec.describe AdministratorsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/dashboard').to route_to('administrators#index')
    end
  end
end
