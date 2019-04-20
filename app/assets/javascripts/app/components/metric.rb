# frozen_string_literal: true

class Metric < Ferro::Component::Base
  class Value < Ferro::Component::Base; end

  class Label < Ferro::Component::Base; end

  def before_create
    @label = option_replace :label
    @value = option_replace :value
    @color = option_replace :color
  end

  def cascade
    add_child :metric_value, Value, content: @value
    metric_value.add_state @color, true if @color
    # add_child :label, Label, content: @label
  end

  def metric_value=(new_value)
    metric_value.set_text new_value
  end
end
