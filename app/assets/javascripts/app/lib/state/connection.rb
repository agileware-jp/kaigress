# frozen_string_literal: true

class Connection
  attr_reader :from, :to

  def initialize(from, to)
    @from = from
    @to = to
  end

  def as_edge
    {
      from: from.id,
      to: to.id
    }.to_n
  end
end
