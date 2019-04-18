# frozen_string_literal: true

require 'app/layout/base_document'
require 'app/components/panel'
require 'app/components/link_button'

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
