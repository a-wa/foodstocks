class RequestsController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    guest_user = User.find_by(email: params[:request][:email])
    if guest_user == nil
      flash[:danger] = '存在しないアカウントです'
    elsif current_user.family_id == guest_user.family_id
      flash[:danger] = 'すでに同じ家族のユーザです'
    elsif
      Request.find_by(family_id: current_user.family_id, guest_id: guest_user.id, status: 1)
      flash[:danger] = '招待中のユーザです　回答をお待ちください'
    elsif
      current_user.invite(guest_user)
      flash[:success] = guest_user.email + 'あてに　招待リクエストを送りました'
    end
    
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
  
  def destroy
    @request = Request.find_by(id: params[:id])
    @request.destroy
    flash[:success] = 'リクエストを取り消しました'
    redirect_back(fallback_location: root_path)
  end
  
  private
  
end
