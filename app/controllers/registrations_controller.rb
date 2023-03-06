class RegistrationsController < Devise::RegistrationsController
  include RoleHelper

  private

  def after_sign_up_path_for(resource)
    path_by_role
  end

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :full_name)
  end

  def account_update_params
    params.require(:user).permit(:email, :password, :password_confirmation, :current_password, :full_name)
  end
end
