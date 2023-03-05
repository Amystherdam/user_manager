require 'rails_helper'

RSpec.describe HomeController, type: :routing do
  describe 'routing' do
    it "routes to #path_by_role" do
      expect(get '/').to route_to(controller: "home", action: "path_by_role")
    end
  end
end
