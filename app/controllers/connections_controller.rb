# frozen_string_literal: true

class ConnectionsController < ApplicationController
  before_action :set_user, only: %i[create]

  def create
    other = User.find_by!(uuid: params[:uuid])

    @connection = @user.connect_to(other)

    render 'users/show'
  end
end
