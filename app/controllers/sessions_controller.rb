class SessionsController < Devise::SessionsController
  include RoleHelper

  private

  def after_sign_in_path_for(resource)
    path_by_role
  end
end
