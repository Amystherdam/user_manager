  class AdministratorsController < ApplicationController
    before_action :user, only: %i[edit]
    helper_method :resource_name
    helper_method :resource

    def index
      @users = User.all
    end

    def edit
      render 'devise/registrations/edit'
    end

    private

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
