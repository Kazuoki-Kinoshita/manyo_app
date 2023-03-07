class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  before_action :login_user_control, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(users_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "ユーザ登録しました！"
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    unless @user.id == current_user.id || admin?
      redirect_to tasks_path
    end
  end


  private 

  def users_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def login_user_control
    redirect_to tasks_path if current_user 
  end
end
