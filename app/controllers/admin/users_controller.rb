class Admin::UsersController < ApplicationController
  skip_before_action :login_required

  def index
    @users = User.all.order(created_at: :desc)
  end  
end
