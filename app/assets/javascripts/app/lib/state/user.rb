# frozen_string_literal: true

class User
  attr_reader :id, :team, :node
  attr_reader :connections

  def initialize(user_json)
    @id = user_json[:id]
    @team = user_json[:team]
    @connections = 0

    @node = `{}`
    @node.JS[:id] = @id
    @node.JS[:group] = @team
  end

  def connections=(value)
    @connections = value
    @node.JS[:size] = 10 + value * 10
  end
end
