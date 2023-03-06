class RegistrationsController < Devise::RegistrationsController
  include RoleHelper

  before_action :affected_user, only: %i[update destroy]

  def update
    authorize @affected_user

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
    authorize @affected_user

    if @affected_user == current_user
      super
    else
      @affected_user.destroy
      redirect_to dashboard_path
    end
  end

  private

  def affected_user
    @affected_user = params[:user].nil? ? User.find(params[:user_id]) : User.find(params[:user][:id])
  end

  def after_update_path_for(resource)
    current_user.admin? ? dashboard_path : profile_path
  end

  def after_sign_up_path_for(resource)
    path_by_role
  end

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :full_name)
  end

  def account_update_params
    params.require(:user).permit(:id, :email, :password, :password_confirmation, :current_password, :full_name)
  end
end
