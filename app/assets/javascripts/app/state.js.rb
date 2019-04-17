# frozen_string_literal: true

require 'opal'
require 'opal-ferro'
require_relative 'lib/base_document'
require_tree './lib/action_cable'
require_tree './lib/state'
require_relative 'components/panel'
require_relative 'components/network'

class GameState < BaseDocument
  TEAMS = %i[red green blue]

  NETWORK_OPTIONS = {
    nodes: {
      shape: 'dot',
      font: {
        size: 72,
        face: 'Tahoma'
      }
    },
    edges: {
      width: 5,
      color: { inherit: 'from' },
      smooth: {
        type: 'continuous'
      }
    },
    physics: {
      stabilization: true,
      barnesHut: {
        gravitationalConstant: -80_000,
        springConstant: 0.001,
        springLength: 200
      }
    },
    interaction: {
      dragNodes: false,
      selectable: false
    },
    groups: { # Copied from default groups
      blue: {
        color: { border: '#2B7CE9', background: '#97C2FC' },
        font: { color: '#2B7CE9' }
      },
      red: {
        color: { border: '#FA0A10', background: '#FB7E81' },
        font: { color: '#FA0A10' }
      },
      green: {
        color: { border: '#41A906', background: '#7BE141' },
        font: { color: '#41A906' }
      }
    }
  }

  def initialize(users, connections)
    @users = {}
    users.each do |u|
      add_user(u)
    end
    @connections = []
    @points = TEAMS.map { |t| [t, 0] }.to_h
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
      @connections << result
      @points[result.team] += 1
    }
  end

  def cascade
    add_child :network_container, Panel, title: 'Status'
    network = network_container.add_content :network, Network, nodes: nodes, edges: edges, options: NETWORK_OPTIONS

    consumer = ActionCable::Consumer.new
    consumer.create_subscription(channel: 'StateChannel', model_type: 'user') do |user_json|
      network.add_node add_user(user_json).as_node
    end
    consumer.create_subscription(channel: 'StateChannel', model_type: 'connection') do |connection_json|
      connection = add_connection(connection_json)
      network.add_edge connection.as_edge
      network.update_node(connection.from.id, size: connection.from.node_size)
      network.update_node(connection.to.id, size: connection.to.node_size)
    end
  end

  private

  def nodes
    @users.values.map(&:as_node)
  end

  def edges
    @connections.map(&:as_edge)
  end

end
