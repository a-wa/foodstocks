module UsersHelper
  def leave_family
    current_user.update(family_id: nil)
    redirect_to new_family_path
  end
end
