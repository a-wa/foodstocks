module SessionsHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !!current_user
  end
  
  def current_family
     @current_family ||= Family.find_by(id: current_user.family_id)
  end
  
    
    
  
    
end
