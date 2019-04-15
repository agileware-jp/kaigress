# frozen_string_literal: true

class Connection
  attr_reader :from, :to

  def initialize(from, to)
    @from = from.tap { |u| u.connections += 1 }
    @to = to.tap { |u| u.connections += 1 }
  end

  def team
    from.team
  end
end
