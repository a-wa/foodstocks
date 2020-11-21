module RequestsHelper
  
  # 招待を受けているが未承認のリクエスト
  def unapproved_requests
    Request.where(guest_id: current_user.id, status: 1)
  end
  
  # 招待しているが未承認のリクエスト
  def requestings
    Request.where(user_id: current_user.id, status: 1)
  end
  
  #def guest_id
   # request=Request.find_by(user_id: current_user.id, status: 1)
  #  request.guest_id
  #end
  
end
