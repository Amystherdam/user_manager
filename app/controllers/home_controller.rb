class HomeController < ApplicationController
  include RoleHelper

  def default_home
    redirect_to path_by_role
  end
end
