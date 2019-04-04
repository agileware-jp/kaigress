# frozen_string_literal: true

class ConnectionsController < ApplicationController
  before_action :set_user, only: %i[create]

  def create
    other = User.find_by!(uuid: params[:uuid])
    # TODO: return reason for the error
    @status_message = 'Connection failed'
    if params[:connection_token] == other.connection_token &&
       @user.connect_to(other)
      @status_message = "Connected with #{other.nickname}"
    end

    render 'users/show'
  end
end
