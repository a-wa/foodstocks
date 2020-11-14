class FamiliesController < ApplicationController
  def new
    @family = Family.new
  end

  def create
    @family = Family.new(family_params)
    
    if @family.save
      flash[:success] = '家族を登録しました'
      redirect_to 
    else
      flash.now[:danger] ='家族の登録に失敗しました'
      render 
    end
    
    
  end
  
  private
  
  def family_params
    params.require(:family).permit(:name)
  end
  
  
end
