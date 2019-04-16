# frozen_string_literal: true

class Connection
  attr_reader :from, :to, :edge

  def initialize(from, to)
    @from = from.tap { |u| u.connections += 1 }
    @to = to.tap { |u| u.connections += 1 }

    @edge = `{}`
    @edge.JS[:from] = from.id
    @edge.JS[:to] = to.id
  end

  def team
    from.team
  end
end
