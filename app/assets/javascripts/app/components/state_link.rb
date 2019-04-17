# frozen_string_literal: true

require_relative 'link_button'

class StateLink < Ferro::Component::Base
  def before_create
    @url = option_replace :url
  end

  def cascade
    add_child :link, LinkButton, content: 'Check Current Landscape!', url: @url
  end
end
