class ApplicationController < ActionController::Base
  def set_user
    @user = User.find_by!(uuid: session[:uuid])
  end
end
