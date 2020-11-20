class MemosController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    @memo = current_user.memos.build(memo_params)
    @foods = current_family.foods.order(purchase_date: :asc)
    if @memo.save
  #    flash[:success] = 'メモしました'
      redirect_to root_path
    else
      @memos = current_family.memos.order(id: :desc)
      flash[:danger] = 'メモできませんでした'
      render 'foods/index'
    end
    
  end

  def destroy
  end
end

private

def memo_params
  params.require(:memo).permit(:content, :family_id, :user_id)
end
