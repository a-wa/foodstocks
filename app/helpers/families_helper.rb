module FamiliesHelper
    
  def host_name(request)
    user_id = request.user_id
    user = User.find(user_id)
    return user.name
  end 
  
  def host_family(request)
    user_id = request.user_id
    user = User.find(user_id)
    family = Family.find(user.family_id)
    return family.name
  end
end
