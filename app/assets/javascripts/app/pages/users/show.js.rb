# frozen_string_literal: true

require 'app/layout/base_document'
require 'app/components/link_button'
require 'app/components/button'
require 'app/components/panel'
require 'app/components/qr_code'
require 'app/components/form'

class UserInfo < BaseDocument
  class EditButton < Button; end

  class NicknameForm < Form
    def before_create
      @options[:for] = 'user'
      @nickname = option_replace :nickname
      super
    end

    def cascade
      super
      add_text_field :nickname, content: @nickname
      add_submit_button 'Save'
    end
  end

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

  def initialize(user, urls:, error:)
    @user = user
    @state_url = urls.fetch(:state)
    @connection_url = urls.fetch(:connection)
    @update_url = urls.fetch(:update)
    @no_user_error = error
    super
  end

  def content
    if @user
      add_child :user_info, Panel
      @header = []
      @header << user_info.add_to_header(:title, Panel::Title, content: @user[:nickname])
      @header << user_info.add_to_header(:edit, EditButton, content: 'Edit', clicked: method(:show_edit))
      user_info.add_content :team, Team, team: @user[:team]
      user_info.add_content :state_link, StateLink, url: @state_url

      add_child :qr_code, Panel, title: 'Your QR-Code'
      qr_code.add_content :qr_code, QrCode, url: @connection_url
    else
      add_child :error, Panel, content: @no_user_error
    end
  end

  private

  def show_edit
    @header.each { |el| el.add_state :hidden, true }
    @nickname_form ||= user_info.add_to_header :nickname_form, NicknameForm, nickname: @user[:nickname], url: @update_url
  end
end
