class FoodsController < ApplicationController
   before_action :require_user_logged_in
   
  def index
    @foods = current_family.foods.order(purchase_date: :desc)
  end

  def new
    @food = current_family.foods.build
  end

  def create
    @food = current_family.foods.build(food_params)
    if @food.save
      flash[:success] = '食材を追加しました'
      redirect_to new_food_path
    else
      flash[:danger] = '食材を追加できませんでした'
      render new_food_path
    end
  end

  def update
    @food = Food.find_by(id: params[:id])
    @food.update(quantity: params[:quantity])
    flash[:success] = @food.name + ' は残り'# + params[:quantity] + 'です'
    redirect_to root_path
    
  end

  def destroy
    @food = Food.find_by(id: params[:id])
    @food.destroy
    flash[:success] = @food.name + ' を使い切りました'
    redirect_to root_path
  end
end

private

def food_params
  params.require(:food).permit(:name, :place, :quantity, :purchase_date)
end