# frozen_string_literal: true

require 'opal'
require 'opal-ferro'
require_tree './components'

class UserPage < Ferro::Document
  def initialize(user, connection_url, no_user_error)
    @user = user
    @connection_url = connection_url
    @no_user_error = no_user_error
    super
  end

  def before_create
    @compositor = MyCompositor.new
  end

  def cascade
    if !@user
      add_child :user_info, Panel, title: @user[:label]
      user_info.add_content :team, Team, team: @user[:team]

      add_child :qr_code, Panel, title: 'Your QR-Code'
      qr_code.add_content :qr_code, QrCode, url: @connection_url
    else
      add_child :error, Panel, content: @no_user_error
    end
  end

  def render
    `document.addEventListener("DOMContentLoaded", function() {#{self};})`
  end
end
