# frozen_string_literal: true

class ConnectionsController < ApplicationController
  before_action :set_user, only: %i[create]

  def index
    @users = User.all
    @connections = Connection.all
    @focused_user = params[:focused_user]
  end

  def create
    other = User.find_by!(uuid: params[:uuid])
    @status_message = if @user.connect_to(other)
                        t('message.connected_with', name: other.nickname)
                      else
                        t('message.already_connected')
                      end

    @root_url = root_url

    render 'common/page'
  end
end
