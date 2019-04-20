# frozen_string_literal: true

class Panel < Ferro::Component::Base
  class Title < Ferro::Element::Text
    def before_create
      @options[:size] = 1
      super
    end
  end

  class Header < Ferro::Component::Base
    def before_create
      @content = option_replace :content
    end

    def cascade
      add_child :title, Title, content: @content if @content
    end
  end

  class Body < Ferro::Component::Base; end

  class Divider < Ferro::Component::Base; end

  class Footer < Ferro::Component::Base; end

  def before_create
    @title = option_replace :title
    @content = option_replace :content
    @id = Ferro::Sequence.new 'divider_'
  end

  def cascade
    add_child :header, Header, content: @title if @title
    add_child :content, Body, content: @content
  end

  def add_to_header(*args)
    add_child :header, Header, prepend: content unless children.key?(:header)
    header.add_child(*args)
  end

  def add_content(*args)
    content.add_child(*args)
  end

  def add_to_footer(*args)
    add_footer unless @footer
    @footer.add_child(*args)
  end

  def add_divider
    content.add_child @id.next, Divider
  end

  private

  def add_footer
    add_child :footer_divider, Divider
    @footer = add_child :footer, Footer
  end
end
