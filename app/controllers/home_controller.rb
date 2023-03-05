class HomeController < ApplicationController
  def path_by_role
    case current_user.role.to_sym
    when :admin
      redirect_to dashboard_path
    when :common_user
      redirect_to profile_path
    end
  end
end
