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
    20 + connections * 10
  end

  def as_node
    node = {
      id: id,
      label: nickname,
      group: team,
      size: node_size
    }
    if link_to_github?
      node.update(
        label: github_username,
        shape: 'image',
        image: "#{github_url}.png?size=40"
      )
    end
    node.to_n
  end

  def link_to_github?
    nickname.start_with? '@'
  end

  def github_url
    "https://github.com/#{github_username}"
  end

  private

  def github_username
    nickname[1..-1]
  end
end
