# frozen_string_literal: true

class Button < Ferro::Form::Button
  def before_create
    @clicked = option_replace :clicked, -> {}
  end

  def clicked
    @clicked.call
  end
end
