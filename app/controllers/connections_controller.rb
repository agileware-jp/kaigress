# frozen_string_literal: true

class ConnectionsController < ApplicationController
  before_action :set_user, only: %i[create]

  def index
    @users = User.all
    @connections = Connection.all
    render :page
  end

  def create
    other = User.find_by!(uuid: params[:uuid])
    # TODO: return reason for the error
    @status_message = if params[:connection_token] != other.connection_token
                        t('message.qr_code_outdated')
                      elsif @user.connect_to(other)
                        t('message.connected_with', name: other.nickname)
                      else
                        t('message.already_connected')
                      end

    @root_url = root_url
    render 'users/page'
  end
end
