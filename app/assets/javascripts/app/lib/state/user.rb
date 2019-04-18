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
      label: link_to_github? ? nickname[1..-1] : nickname,
      group: team,
      size: node_size,
      link: link_to_github?
    }.to_n
  end

  private

  def link_to_github?
    nickname.start_with? '@'
  end
end
