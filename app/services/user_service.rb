class UserService
  def user_counts
    {
      all: User.all.count,
      role_admin: User.where(role: :admin).count,
      role_common: User.where(role: :common_user).count
    }
  end
end
