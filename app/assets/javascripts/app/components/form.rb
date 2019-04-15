# frozen_string_literal: true

class Form < Ferro::Component::Base
  def before_create
    @domtype = :form
    @model_name = option_replace :for
    @url = option_replace :url
    @inputs = {}
  end

  def after_create
    set_attribute :action, @url if @url
    set_attribute :method, :post
  end

  def cascade
    add_child :authenticity_token, Ferro::Form::Input, type: :hidden, name: 'authenticity_token'
  end

  def add_label(field, content)
    add_child("label_for_#{field}", Ferro::Form::Label, content: content).tap do |result|
      result.set_attribute :for, field_id(field)
    end
  end

  def add_text_field(field)
    add_child("text_field_for_#{field}", Ferro::Form::Input).tap do |result|
      result.set_attribute :name, field_name(field)
      @inputs[field] = result
    end
  end

  def add_submit_button(label)
    add_child(:submit, Button, type: :submit, content: label).tap do |result|
      result.set_attribute :type, 'submit'
    end
  end

  private

  def field_id(field)
    "#{@model_name}_#{field}"
  end

  def field_name(field)
    @model_name ? "#{@model_name}[#{field}]" : @field
  end
end
