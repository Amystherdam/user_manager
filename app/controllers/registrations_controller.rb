class RegistrationsController < Devise::RegistrationsController
  include RoleHelper

  before_action :check_admin, only: %i[update destroy]

  def update
    if current_user.admin?
      if @affected_user.update_without_password(account_update_params.except(:current_password))
        redirect_to after_update_path_for(current_user)
      else
        render "edit"
      end
    else
      super
    end
  end

  def destroy
    user = User.find(params[:user_id])

    if user == current_user
      super
    else
      user.destroy
      redirect_to dashboard_path
    end
  end

  private

  def after_update_path_for(resource)
    current_user.admin? ? dashboard_path : profile_path
  end

  def after_sign_up_path_for(resource)
    path_by_role
  end

  def check_admin
    affected_user
    redirect_to profile_path unless current_user.admin? || @affected_user == current_user
  end

  def affected_user
    @affected_user = params[:user].nil? ? User.find(params[:user_id]) : User.find(params[:user][:id])
  end

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :full_name)
  end

  def account_update_params
    params.require(:user).permit(:id, :email, :password, :password_confirmation, :current_password, :full_name)
  end
end
