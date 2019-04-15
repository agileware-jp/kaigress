# frozen_string_literal: true

class Team < Ferro::Component::Base
  def before_create
    @team = option_replace :team
    @options[:content] = "Team #{@team.capitalize}"
  end

  def after_create
    add_state @team, true
  end
end
