# frozen_string_literal: true

require 'app/layout/base_document'
require 'app/components/link_button'
require 'app/components/button'
require 'app/components/panel'
require 'app/components/qr_code'

class UserInfo < BaseDocument
  class EditButton < Button; end

  class Team < Ferro::Component::Base
    def before_create
      @team = option_replace :team
    end

    def after_create
      add_child :team_badge, Ferro::Element::Image, src: "/images/#{@team}.png"
    end
  end

  class StateLink < Ferro::Component::Base
    def before_create
      @url = option_replace :url
    end

    def cascade
      add_child :button, LinkButton, content: 'Check Current Landscape!', url: @url
    end
  end

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
      user_info.add_to_header :edit, EditButton, content: 'Edit'
      user_info.add_content :team, Team, team: @user[:team]
      user_info.add_content :state_link, StateLink, url: @state_url

      add_child :qr_code, Panel, title: 'Your QR-Code'
      qr_code.add_content :qr_code, QrCode, url: @connection_url
    else
      add_child :error, Panel, content: @no_user_error
    end
  end
end
