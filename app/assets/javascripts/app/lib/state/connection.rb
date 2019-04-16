# frozen_string_literal: true

class Connection
  attr_reader :from, :to, :edge

  def initialize(from, to)
    @from = from
    @to = to

    @edge = `{}`
    @edge.JS[:from] = from.id
    @edge.JS[:to] = to.id
  end

  def team
    from.team
  end
end
