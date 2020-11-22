module RequestsHelper
  
  # 招待を受けているが未承認のリクエスト
  def unapproved_requests
    Request.where(guest_id: current_user.id, status: 1)
  end
  
   #招待しているが未承認のリクエスト 
#  def requestings
 #   self.requests.find_by(status: 1)
 # end
end
