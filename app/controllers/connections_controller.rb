# frozen_string_literal: true

class ConnectionsController < ApplicationController
  before_action :set_user, only: %i[create]

  def index
    @users = User.all
    @connections = Connection.all
    @focused_user = params[:focused_user]
    @eos = ENV['END_OF_SERVICE'].present?
  end

  def create
    return redirect_to root_url unless @user

    other = User.find_by!(uuid: params[:uuid])
    connection = @user.connect_to(other)
    @status_message = if connection.valid?
                        t('message.connected_with', name: other.nickname)
                      else
                        connection.errors.full_messages[0]
                      end

    @root_url = root_url

    render 'common/page'
  end
end
