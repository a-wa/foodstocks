class FoodsController < ApplicationController
   before_action :require_user_logged_in
   before_action :have_family?
   
  def index
    @foods = current_family.foods.order(purchase_date: :asc)
    @memos = current_family.memos.order(id: :desc)
    @memo = current_user.memos.build
  end

  def new
    @food = current_family.foods.build
  end

  def create
    @food = current_family.foods.build(food_params)
    if @food.save
      flash[:success] = @food.name + 'を追加しました'
      redirect_to new_food_path
    else
   #   flash[:danger] = '食材を追加できませんでした'
      render new_food_path
    end
  end

  def update
    @food = Food.find_by(id: params[:id])
    @food.update(food_params)
    flash[:success] = @food.name + ' は残り' + @food.quantity + ' ' + @food.unit + ' です'
    redirect_to foods_path
    
  end

  def destroy
    @food = Food.find_by(id: params[:id])
    @food.destroy
    flash[:success] = @food.name + ' を使い切りました'
    redirect_to foods_path
  end
  
  def meats
    @foods = current_family.foods
    @meats = @foods.where(category: 1).order(purchase_date: :asc)
    @memos = current_family.memos.order(id: :desc)
    @memo = current_user.memos.build
  end
  
  def veges
    @foods = current_family.foods
    @veges = @foods.where(category: 2).order(purchase_date: :asc)
    @memos = current_family.memos.order(id: :desc)
    @memo = current_user.memos.build

  end
  
  def drinks
    @foods = current_family.foods
    @drinks = @foods.where(category: 3).order(purchase_date: :asc)
    @memos = current_family.memos.order(id: :desc)
    @memo = current_user.memos.build

  end
  
  def others
    @foods = current_family.foods
    @others = @foods.where(category: 4).order(purchase_date: :asc)
    @memos = current_family.memos.order(id: :desc)
    @memo = current_user.memos.build

  end
end

private

def food_params
  params.require(:food).permit(:name, :place, :quantity, :unit, :category, :purchase_date)
end