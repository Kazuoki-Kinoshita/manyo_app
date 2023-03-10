class ApplicationController < ActionController::Base
  include SessionsHelper
  include TasksHelper
  before_action :login_required

  private

  def login_required
    redirect_to new_session_path unless current_user 
  end
end