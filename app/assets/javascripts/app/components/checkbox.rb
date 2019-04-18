# frozen_string_literal: true

class Checkbox < Ferro::Component::Base
  def before_create
    @label = option_replace :label
    @checked = option_replace :checked
  end

  def cascade
    add_child :checkbox, Ferro::Form::CheckBox, checked: @checked
    add_child :label, Ferro::Form::Label, for: checkbox.dom_id, content: @label
  end

  def checked?
    checkbox.checked?
  end
end
