# frozen_string_literal: true

require 'app/layout/base_document'
require 'app/components/panel'
require 'app/components/form'

class RegisterUser < BaseDocument
  def initialize(register_url, explanation)
    @register_url = register_url
    @explanation = explanation
    super
  end

  def content
    add_child :registration, Panel, title: 'Welcome to Kaigress'
    form = registration.add_content :form, Form, for: :user, url: @register_url
    form.add_label :nickname, 'Nickname'
    form.add_text_field :nickname
    form.add_submit_button 'Create User'
    registration.add_content :explanation, Ferro::Element::Text, content: @explanation
  end
end
