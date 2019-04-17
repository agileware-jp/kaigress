# frozen_string_literal: true

class Team < Ferro::Component::Base
  def before_create
    @team = option_replace :team
  end

  def after_create
    add_child :team_badge, Ferro::Element::Image, src: "/images/#{@team}.png"
  end
end
