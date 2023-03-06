class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    render 'errors/not_authorized', status: :forbidden
  end

end
