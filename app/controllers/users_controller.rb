class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show, :update, :password_edit]
  before_action :correct_user, only: [:show, :update, :edit, :password_edit]
  before_action :have_family?, only: [:show, :edit]

  def show
    @user = User.find(params[:id])
    @users = User.where(family_id: current_user.family_id).where.not(id: current_user.id)
    @requests = Request.where(family_id: current_user.family_id, status: 1)
   # @guests = current_user.inviting_users
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
     # flash.now[:danger] = 'ユーザの登録に失敗しました'
      render :new
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = current_user.update(user_params)
    if current_user.family_id == nil
      current_user.requests.destroy_all
      flash[:success] = '家族から抜けました'
    else
      flash[:success] = 'ユーザ情報を編集しました'     
    end
    redirect_to edit_user_path
  end
  
  def password_edit
    @user = User.find(params[:id])
  end
  
  #def password_update わからない！！！！！
  #  @user = User.find(params[:id])
 #   if correct_password(params[:old_password])
  #    if @user.update(password: params[:password])
   #     flash[:success] = 'パスワードを変更しました'
  #      redirect_to @user
   #   else
    #    flash[:danger] = 'パスワードを変更できませんでした'
     #   render :password_edit
     # end
  #  else
   #   flash[:danger] = 'パスワードが間違っています'
    #  render :password_edit
    #end
#  end
    
  
  private
  
  
  def user_params
    params.fetch(:user, {}).permit(:name, :email, :password, :password_confirmation, :image, :family_id, :old_password)
  end
  
  def correct_user
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to(root_path)
    end
  end
  
  def correct_password(password)
    @user = User.find(params[:id])
    if @user && @user.authenticate(password)
      return true
    else
      return false
    end
  end
  

  

end