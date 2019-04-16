# frozen_string_literal: true

class DataSet
  def initialize(initial_elements = nil)
    @obj = `new vis.DataSet(#{initial_elements || []})`
  end

  def add(element)
    @obj.JS.add(element.to_n)
  end

  def to_n
    @obj
  end
end
