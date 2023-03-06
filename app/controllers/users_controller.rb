class UsersController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(users_params)
    if @user.save
      flash[:notice] = "ユーザ登録しました！"
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end


  private 

  def users_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
