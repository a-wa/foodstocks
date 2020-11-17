module RequestsHelper
    
  def unapproved_requests
    Request.where(guest_id: current_user.id, status: 1)
  end
  
end
