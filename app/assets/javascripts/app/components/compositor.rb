class MyCompositor < Ferro::Compositor

  def map(_theme)
    {
      'Panel': %w[futurepanel],
      'Panel::Header': %w[futurepanel__header],
      'Panel::Title': %w[futurepanel__title],
      'Panel::Body': %w[futurepanel__body]
    }
  end
end
