module AdminHelper
  def admin_only
    unless current_user.admin == "管理者"
      redirect_to tasks_path, notice: "一般ユーザーは管理者ページに入れません"
    end
  end
end
