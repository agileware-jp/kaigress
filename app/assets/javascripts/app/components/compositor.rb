# frozen_string_literal: true

class MyCompositor < Ferro::Compositor
  def map(_theme)
    {
      'Panel': %w[futurepanel],
      'Panel::Header': %w[futurepanel__header],
      'Panel::Title': %w[futurepanel__title],
      'Panel::Body': %w[futurepanel__body],
      'Form': %w[futureinput futureinput--text],
      'Button': %w[futurebutton]
    }
  end
end
