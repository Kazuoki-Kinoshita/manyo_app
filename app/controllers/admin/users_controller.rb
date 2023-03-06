class Admin::UsersController < ApplicationController
  skip_before_action :login_required
  before_action :set_user, only: [:edit, :update, :destroy]
  before_action :admin_user

  def index
    @users = User.all.includes(:tasks)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(admin_users_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "ユーザ登録しました！"
      redirect_to admin_users_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(admin_users_params)
      flash[:notice] = "ユーザ情報を編集しました！"
      redirect_to admin_users_path
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:notice] = "ユーザを削除しました！"
    redirect_to admin_users_path
  end

  
  private 

  def admin_users_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def admin_user
    unless current_user.admin?
      flash[:danger] = "管理者以外はアクセスできません！"
      redirect_to tasks_path
    end
  end  
end
