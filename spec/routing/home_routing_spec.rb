require 'rails_helper'

RSpec.describe HomeController, type: :routing do
  describe 'routing' do
    it "routes to #default_home" do
      expect(get '/').to route_to(controller: "home", action: "default_home")
    end
  end
end
