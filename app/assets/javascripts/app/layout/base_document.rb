# frozen_string_literal: true

require_relative 'compositor'

class BaseDocument < Ferro::Document
  class CopyrightNotice < Ferro::Component::Base
    def cascade
      add_child :copyright, Ferro::Element::ExternalLink, content: 'Agileware Inc.', href: 'https://agileware.jp'
      add_child :link, Ferro::Element::ExternalLink, content: 'Published on Github', href: 'https://github.com/agileware-jp/rubykaigi2019-kaigress'
    end
  end

  def before_create
    @compositor = MyCompositor.new
  end

  def cascade
    content
    add_child :copyright_footer, CopyrightNotice
  end

  def content; end

  def render
    `document.addEventListener("DOMContentLoaded", function() {#{self};})`
  end
end
