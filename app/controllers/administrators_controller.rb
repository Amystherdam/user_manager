  class AdministratorsController < ApplicationController

    rescue_from ActiveRecord::RecordNotFound, with: :user_not_found

    before_action :user, only: %i[edit]
    before_action :set_roles, only: %i[ edit new create update ]
    before_action :dependency_injection, only: %i[index create]

    helper_method :resource_name
    helper_method :resource

    def index
      @users = User.all
      authorize @users

      @total_user_count = @user_service.user_counts[:all]
      @admin_user_count = @user_service.user_counts[:role_admin]
      @common_user_count = @user_service.user_counts[:role_common]
      @channel_key = SecureRandom.uuid.gsub('-', '')[0..4].hex
    end

    def edit
      authorize @user
      @selected_role = @user.role
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
        ActionCable.server.broadcast(
          'user-count',
          {
            total_user_count: @user_service.user_counts[:all],
            admin_user_count: @user_service.user_counts[:role_admin],
            common_user_count: @user_service.user_counts[:role_common]
          }
        )

        redirect_to dashboard_path, notice: 'User was successfully created'
      else
        render :new
      end
    end

    def users_spreadsheet
      if params[:user] && params[:user][:file] && params[:user][:channel_key]
        file = params[:user][:file].tempfile
        channel_key = params[:user][:channel_key]
        file_path = Rails.root.join('tmp', 'uploads', params[:user][:file].original_filename)

        FileUtils.mkdir_p(File.dirname(file_path))
        FileUtils.mv(file.path, file_path)

        UploadUsersSpreadsheetJob.perform_later(file_path.to_s, channel_key)
      else
        render plain: 'Arquivo não encontrado.', status: :bad_request
      end
    end

    private

    def dependency_injection
      @user_service = UserService.new
    end

    def set_roles
      @roles = User.roles.keys
    end

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
      params.require(:user).permit(:email, :password, :password_confirmation, :full_name, :role, :file)
    end
  end
