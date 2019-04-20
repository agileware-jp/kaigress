# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[new show update]

  def new
    return redirect_to :root if @user

    @register_url = users_path
    @explanation = t('message.username_explanation')

    render 'common/page'
  end

  def show
    if @user
      @urls = {
        connection: qr_code_url,
        state: state_url(focused_user: @user.id),
        update: update_url
      }
    else
      @urls = {}
      @error = t('message.no_user')
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
