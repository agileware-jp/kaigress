# frozen_string_literal: true

require_relative 'button'

class Form < Ferro::Component::Base
  def before_create
    @domtype = :form
    @model_name = option_replace :for
    @url = option_replace :url
    @labels = {}
    @inputs = {}
  end

  def after_create
    set_attribute :action, @url if @url
    set_attribute :method, :post
  end

  def cascade
    add_child :authenticity_token, Ferro::Form::Input, type: :hidden, name: 'authenticity_token', content: csrf_token
  end

  def add_label(field, content)
    add_child("label_for_#{field}", Ferro::Form::Label, content: content).tap do |result|
      @labels[field] = result
    end
  end

  def add_text_field(field, *args)
    add_child("text_field_for_#{field}", Ferro::Form::Input, *args).tap do |result|
      result.set_attribute :name, field_name(field)
      @inputs[field] = result
      @labels[field].set_attribute :for, result.dom_id if @labels.key? field
    end
  end

  def add_submit_button(label)
    add_child(:submit, Button, type: :submit, content: label).tap do |result|
      result.set_attribute :type, 'submit'
    end
  end

  private

  def field_name(field)
    @model_name ? "#{@model_name}[#{field}]" : @field
  end

  def csrf_token
    `(document.getElementsByName('csrf-token').item(0) || { content: '' }).content`
  end
end
