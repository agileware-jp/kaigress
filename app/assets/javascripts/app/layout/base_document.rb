# frozen_string_literal: true

require_relative 'compositor'

class BaseDocument < Ferro::Document
  def before_create
    @compositor = MyCompositor.new
  end

  def render
    `document.addEventListener("DOMContentLoaded", function() {#{self};})`
  end
end
