# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[new show]

  def new
    if @user
      redirect_to :root
    else
      @register_url = users_path
      render :page
    end
  end

  def show
    @qr_code_url = qr_code_url
    @state_url = state_url
    @no_user_error = t('message.no_user')
    render :page
  end

  def create
    user = User.new(user_params)
    if user.save
      cookies.encrypted[:uuid] = user.uuid
      redirect_to :root
    else
      # TODO
    end
  end

  private

  def user_params
    params.require(:user).permit(:nickname)
  end

  def qr_code_url
    ERB::Util.url_encode(connect_url(uuid: @user.uuid, connection_token: @user.connection_token)) if @user
  end
end
