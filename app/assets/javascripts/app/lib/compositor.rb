# frozen_string_literal: true

class MyCompositor < Ferro::Compositor
  def map(_theme)
    {
      'Panel': %w[futurepanel],
      'Panel::Header': %w[futurepanel__header],
      'Panel::Title': %w[futurepanel__title],
      'Panel::Body': %w[futurepanel__body],
      'Panel::Divider': %w[futurepanel__divider],
      'Panel::Footer': %w[futurepanel__footer],
      'Panel::Link': %w[futurepanel__link],
      'Panel::FooterLink': %w[futurepanel__footerlink],
      'Team': %w[team],
      'Form': %w[futureinput futureinput--text],
      'Button': %w[futurebutton],
      'StateLink': %w[state-link],
      'Network': %w[team-network]
    }
  end
end
