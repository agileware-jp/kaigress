# frozen_string_literal: true

class ConnectionsController < ApplicationController
  before_action :basic_auth, only: %i[index], if: -> { Rails.env.production? }
  before_action :set_user, only: %i[create]

  def index; end

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

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['BASIC_AUTH_USER'] && password == ENV['BASIC_AUTH_PASSWORD']
    end
  end
end
