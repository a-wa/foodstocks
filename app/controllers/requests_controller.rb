class RequestsController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    guest_user = User.find_by(email: params[:request][:email])
    current_user.invite(guest_user)
    flash[:success] = guest_user.email + 'あてに　招待リクエストを送りました'
    redirect_to user_path(current_user)
  end
  
  def update
    current_user.answer(params[:id], params[:status])
    if params[:status] == '2'
      current_user.join_family(params[:id])
      flash[:success] = 'リクエストを承認しました'
      redirect_to user_path(current_user)
    elsif params[:status] == '3'
      flash[:success] = 'リクエストを拒否しました'
      redirect_to new_family_path
    end
  end
  
  private
  
end
