class FamiliesController < ApplicationController
  before_action :require_user_logged_in
  
  def new
    @family = Family.new
    @requests = Request.where(guest_id: current_user.id, status: 1)
    
  end

  def create
    @family = Family.new(family_params)
    
    if @family.save
      flash[:success] = '家族を登録しました'
      current_user.make_family_id(@family)
      redirect_to user_path(current_user)
    else
     # flash.now[:danger] ='家族の登録に失敗しました'
      render :new
    end
    
  end
  
  private
  
  def family_params
    params.require(:family).permit(:name)
  end
  
end
