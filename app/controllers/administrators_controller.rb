  class AdministratorsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :user_not_found

    before_action :user, only: %i[edit]

    helper_method :resource_name
    helper_method :resource

    def index
      @users = User.all
      authorize @users
    end

    def edit
      authorize @user
      render 'devise/registrations/edit'
    end

    def new
      @user = User.new
      authorize @user
    end
    
    def create
      @user = User.new(user_params)
      authorize @user
  
      if @user.save
        redirect_to dashboard_path, notice: 'User was successfully created'
      else
        render :new
      end
    end

    private

    def user_not_found
      render 'errors/not_found', status: :not_found
    end

    def resource_name
      :user
    end

    def resource
      @user ||= User.new
    end

    def user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :full_name)
    end
  end
