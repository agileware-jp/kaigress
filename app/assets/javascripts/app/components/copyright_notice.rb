# frozen_string_literal: true

class CopyrightNotice < Ferro::Component::Base
  def cascade
    add_child :copyright, Ferro::Element::ExternalLink, content: 'Agileware Inc.', href: 'https://agileware.jp'
    add_child :link, Ferro::Element::ExternalLink, content: 'Published on Github', href: 'https://github.com/agileware-jp/rubykaigi2019-kaigress'
  end
end
