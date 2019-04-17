# frozen_string_literal: true

class Panel < Ferro::Component::Base
  class Title < Ferro::Element::Text; end

  class Header < Ferro::Component::Base
    def before_create
      @content = option_replace :content
    end

    def cascade
      add_child :title, Title, size: 1, content: @content
    end
  end

  class Body < Ferro::Component::Base
  end

  class Divider < Ferro::Component::Base
  end

  class Footer < Ferro::Component::Base
    def before_create
      @content = option_replace :content
      @href = option_replace :href
    end
    def cascade
      add_child :copyright, FooterLink, content: 'Agileware Inc.', href: 'https://agileware.jp'
      add_child :link, FooterLink, content: 'Published on Github', href: 'https://github.com/agileware-jp/rubykaigi2019-kaigress'
    end
  end

  class Link < Ferro::Component::Base
    def before_create
      @content = option_replace :content
      @href = option_replace :href
    end

    def cascade
      add_child :link, Ferro::Element::ExternalLink, content: @content, href: @href
    end
  end

  class FooterLink < Link; end

  def before_create
    @title = option_replace :title
    @content = option_replace :content
    @hide_footer = option_replace :hide_footer
    @id = Ferro::Sequence.new 'divider_'
  end

  def cascade
    add_child :header, Header, content: @title if @title
    add_child :content, Body, content: @content
    return if @hide_footer
    add_child :footer_divider, Divider
    add_child :footer, Footer
  end

  def add_content(*args)
    content.add_child(*args)
  end

  def add_divider
    content.add_child @id.next, Divider
  end
end
