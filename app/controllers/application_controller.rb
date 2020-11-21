class ApplicationController < ActionController::Base
  
  include SessionsHelper
  include RequestsHelper
  
  private

  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
  
  def have_family?
    unless current_user.family_id
      render new_family_path
    end
  end
  
    
end
