class UserPolicy < ApplicationPolicy
  def index?
    user.admin?
  end

  def update?
    user_is_admin_or_owner?
  end

  def edit?
    update?
  end

  def destroy?
    user_is_admin_or_owner?
  end

  private

  def user_is_admin_or_owner?
    user.admin? || user == record
  end
end
