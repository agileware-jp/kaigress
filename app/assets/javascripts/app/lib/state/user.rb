# frozen_string_literal: true

class User
  attr_reader :id, :team, :nickname
  attr_accessor :connections

  def initialize(user_json)
    @id = user_json[:id]
    @team = user_json[:team]
    @nickname = user_json[:nickname]
    @connections = 0
  end

  def node_size
    10 + connections * 10
  end

  def as_node
    {
      id: id,
      label: nickname,
      group: team,
      size: node_size
    }.to_n
  end
end
