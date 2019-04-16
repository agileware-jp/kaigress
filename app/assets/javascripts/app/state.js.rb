# frozen_string_literal: true

require 'opal'
require 'opal-ferro'
require_relative 'lib/base_document'
require_tree './lib/state'
require_relative 'components/panel'
require_relative 'components/network'

class GameState < BaseDocument
  TEAMS = %i[red green blue]

  def initialize(users, connections)
    @users = {}
    users.each do |u|
      add_user(u)
    end
    @connections = TEAMS.map { |t| [t, []] }.to_h
    connections.each do |c|
      add_connection(c)
    end
    super
  end

  def add_user(user_json)
    User.new(user_json).tap { |result|
      @users[result.id] = result
    }
  end

  def add_connection(connection_json)
    Connection.new(@users[connection_json[:from]], @users[connection_json[:to]]).tap { |result|
      result.from.connections += 1
      result.to.connections += 1
      @connections[result.team] << result
    }
  end

  def cascade
    add_child :network, Panel, title: 'Status'
    network.add_content :network, Network, nodes: @users.values.map(&:node), edges: @connections.values.flatten.map(&:edge)
  end
end
