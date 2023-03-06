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

    private

    def user_not_found
      render 'errors/not_found', status: :not_found
    end

    def resource_name
      :user
    end

    def resource
      @user
    end

    def user
      @user = User.find(params[:id])
    end
  end
