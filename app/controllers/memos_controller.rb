class MemosController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
#  before_action :have_family?
  
  def create
    @memo = current_user.memos.build(memo_params)
#    @foods = current_family.foods.order(purchase_date: :asc)
    if @memo.save
  #    flash[:success] = 'メモしました'
      redirect_to foods_path
    else
      @memos = current_family.memos.order(id: :desc)
      flash[:warning] = 'メモできませんでした'
      redirect_to foods_path
    end
    
  end

  def destroy
    @memo.destroy
    redirect_to foods_path
  end
end

private

def memo_params
  params.require(:memo).permit(:content, :family_id, :user_id)
end

def correct_user
  @memo = current_user.memos.find_by(id: params[:id])
  unless @memo
    redirect_to root_url
  end
end