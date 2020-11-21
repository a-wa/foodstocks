class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show, :update]
  before_action :correct_user, only: [:show, :update]

  def show
    @user = User.find(params[:id])
    @users = User.where(family_id: current_user.family_id).where.not(id: current_user.id)
    @requests = Request.where(guest_id: current_user.id, status: 1)
#    requests = Request.find_by(user_id: current_user.id, status: 1)
 #   @inviting_users = User.where(id: requests.guest_id)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました'
      render :new
    end
  end
  
  def update
    @user = current_user.update(user_params)
    redirect_to user_path
  end
    
  
  private
  
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image)
  end
  
  def correct_user
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to(root_path)
    end
  end

end
