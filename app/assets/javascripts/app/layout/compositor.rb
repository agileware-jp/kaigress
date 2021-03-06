# frozen_string_literal: true

class MyCompositor < Ferro::Compositor
  def map(_theme)
    {
      'Panel': %w[futurepanel],
      'Panel::Header': %w[futurepanel__header panel-header],
      'Panel::Title': %w[futurepanel__title],
      'Panel::Body': %w[futurepanel__body],
      'Panel::Divider': %w[futurepanel__divider],
      'Panel::Footer': %w[futurepanel__footer],
      'Form': %w[futureinput futureinput--text],
      'Button': %w[futurebutton],
      'Checkbox': %w[checkbox],
      'Metric': %w[futuremetric],
      'Metric::Value': %w[futuremetric__value],
      'UserInfo::EditButton': %w[edit-button],
      'UserInfo::NicknameForm': %w[nickname-form],
      'UserInfo::Team': %w[team],
      'UserInfo::StateLink': %w[state-link],
      'BaseDocument::CopyrightNotice': %w[copyright-notice],
      'GameState::Points': %w[points],
      'GameState::FarewellMessage': %w[farewell-message],
      'Network': %w[team-network]
    }
  end
end
