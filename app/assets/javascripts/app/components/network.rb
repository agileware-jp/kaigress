# frozen_string_literal: true

require_tree '../lib/network'

class Network < Ferro::Component::Base
  extend Native::Helpers

  alias_native :fit
  alias_native :focus

  def before_create
    @nodes = DataSet.new option_replace(:nodes, [])
    @edges = DataSet.new option_replace(:edges, [])

    @network_options = option_replace(:options, {})
  end

  def cascade
    @native = `new vis.Network(#{element}, { nodes: #{@nodes.to_n}, edges: #{@edges.to_n}}, #{@network_options.to_n})`
  end

  def add_node(node)
    @nodes.add(node)
  end

  def update_node(id, attributes)
    @nodes.update(attributes.merge(id: id))
  end

  def add_edge(edge)
    @edges.add(edge)
  end

  def on(event, &handler)
    @native.JS.on(event, ->(data) { handler.call Hash.new(data) })
  end
end
