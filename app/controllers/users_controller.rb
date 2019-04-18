# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[new show update]

  def new
    if @user
      redirect_to :root
    else
      @register_url = users_path
      @explanation = t('message.username_explanation')

      render 'common/page'
    end
  end

  def show
    if @user
      @qr_code_url = qr_code_url
      @state_url = state_url(focused_user: @user.id)
    else
      @no_user_error = t('message.no_user')
    end

    render 'common/page'
  end

  def create
    user = User.new(user_params)
    if user.save
      cookies.permanent.encrypted[:uuid] = user.uuid
      redirect_to :root
    else
      # TODO
    end
  end

  def update
    @user&.update(user_params)
    redirect_to :root
  end

  private

  def user_params
    params.require(:user).permit(:nickname)
  end

  def qr_code_url
    ERB::Util.url_encode(connect_url(uuid: @user.uuid)) if @user
  end
end
