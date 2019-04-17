# frozen_string_literal: true

require 'opal'
require 'opal-ferro'
require_relative 'layout/base_document'
require_relative 'components/panel'
require_relative 'components/team'
require_relative 'components/qr_code'
require_relative 'components/form'
require_relative 'components/state_link'

class UserInfo < BaseDocument
  def initialize(user, connection_url, state_url, no_user_error)
    @user = user
    @state_url = state_url
    @connection_url = connection_url
    @no_user_error = no_user_error
    super
  end

  def content
    if @user
      add_child :user_info, Panel, title: @user[:nickname]
      user_info.add_content :team, Team, team: @user[:team]
      user_info.add_child :state_link, StateLink, url: @state_url

      add_child :qr_code, Panel, title: 'Your QR-Code'
      qr_code.add_content :qr_code, QrCode, url: @connection_url
    else
      add_child :error, Panel, content: @no_user_error
    end
  end
end

class RegisterUser < BaseDocument
  def initialize(register_url)
    @register_url = register_url
    super
  end

  def content
    add_child :registration, Panel, title: 'Welcome to Kaigress'
    form = registration.add_content :form, Form, for: :user, url: @register_url
    form.add_label :nickname, 'Nickname'
    form.add_text_field :nickname
    form.add_submit_button 'Create User'
  end
end

class Connected < BaseDocument
  def initialize(message, root_url)
    @message = message
    @root_url = root_url
    super
  end

  def content
    add_child :message, Panel, content: @message
    message.add_child :back, LinkButton, content: 'Back to Home', url: @root_url
  end
end
