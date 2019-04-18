# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'as_json' do
    subject { user.as_json }

    context 'normal user' do
      let(:user) { create :user, team: :red, nickname: 'Bob' }

      it { is_expected.to eq(id: user.id, nickname: 'Bob', team: 'red', github: false) }
    end

    context 'Github user' do
      let(:user) { create :user, team: :red, nickname: '@Bob' }

      it { is_expected.to eq(id: user.id, nickname: 'Bob', team: 'red', github: true) }
    end
  end
end
