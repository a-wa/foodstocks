module FamiliesHelper
    
  def host_name(request)
    user_id = request.user_id
    user = User.find(user_id)
    return user.name
  end  
  
end
