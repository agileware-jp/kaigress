# frozen_string_literal: true

require 'app/layout/base_document'

require 'app/lib/action_cable'
require 'app/lib/state'

require 'app/components/panel'
require 'app/components/network'
require 'app/components/button'
require 'app/components/checkbox'

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
      dragNodes: false
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

  def initialize(users, connections, focused_user)
    @users = {}
    users.each do |u|
      add_user(u)
    end
    @connections = []
    @points = TEAMS.map { |t| [t, 0] }.to_h
    connections.each do |c|
      add_connection(c)
    end
    @focused_user = focused_user
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

  def content
    add_child :network_container, Panel, title: 'Status'
    @network = network_container.add_content :network, Network, nodes: nodes, edges: edges, options: NETWORK_OPTIONS

    network_container.add_to_footer :reset_button, Button, content: 'Reset', clicked: method(:reset_view)
    @reset_on_update = network_container.add_to_footer :reset_on_update, Checkbox, label: 'Reset on Update'

    @network.on('stabilized') { focus_on_user } if @focused_user

    handle_websocket
    handle_node_click
  end

  private

  def team_centers
    TEAMS.map { |t| { id: t, hidden: true }.to_n }
  end

  def nodes
    @users.values.map(&:as_node) + team_centers
  end

  def edges
    @connections.map(&:as_edge) + @users.values.map { |u| { from: u.team, to: u.id }.to_n }
  end

  def handle_websocket
    consumer = ActionCable::Consumer.new
    consumer.create_subscription(channel: 'StateChannel', model_type: 'user') do |user_json|
      user = add_user(user_json)
      @network.add_node user.as_node
      @network.add_edge({ from: user.team, to: user.id }.to_n)
      reset_view if @reset_on_update.checked?
    end
    consumer.create_subscription(channel: 'StateChannel', model_type: 'connection') do |connection_json|
      connection = add_connection(connection_json)
      handle_new_connection(connection)
      reset_view if @reset_on_update.checked?
    end
  end

  def handle_new_connection(connection)
    @network.instance_eval {
      add_edge connection.as_edge
      update_node(connection.from.id, size: connection.from.node_size)
      update_node(connection.to.id, size: connection.to.node_size)
    }
  end

  def handle_node_click
    @network.on('selectNode') { |data|
      selected_user = @users[data[:nodes][0]]
      next unless selected_user.github_url

      `window.open(#{selected_user.github_url})`
    }
  end

  def reset_view
    @network.fit
  end

  def focus_on_user
    @network.focus(@focused_user, scale: 0.5)
  end
end
