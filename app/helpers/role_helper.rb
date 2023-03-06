module RoleHelper
  def path_by_role
    case current_user.role.to_sym
    when :admin
      dashboard_path
    when :common_user
      profile_path
    end
  end
end
