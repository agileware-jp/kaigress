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

  def before_create
    @title = option_replace :title
    @content = option_replace :content
  end

  def cascade
    add_child :header, Header, content: @title if @title
    add_child :content, Body, content: @content
  end

  def add_content(*args)
    content.add_child(*args)
  end
end
