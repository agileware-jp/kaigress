# frozen_string_literal: true

class DataSet
  def initialize(initial_elements = nil)
    @obj = `new vis.DataSet(#{initial_elements || []})`
  end

  def to_n
    @obj
  end
end