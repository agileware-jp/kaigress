# frozen_string_literal: true

class LinkButton < Button
  def before_create
    @url = option_replace :url
  end

  def clicked
    `document.location.href = #{@url}`
  end
end
