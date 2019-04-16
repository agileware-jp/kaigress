# frozen_string_literal: true

class DataSet
  extend Native::Helpers

  alias_native :add

  def initialize(initial_elements = nil)
    @native = `new vis.DataSet(#{initial_elements || []})`
  end

  def to_n
    @native
  end
end
