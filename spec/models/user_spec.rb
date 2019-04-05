# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#connect_to' do
    let(:user) { create :user, team: :red }
    let(:other_user) { create :user, team: :red }

    it 'updates connection_token' do
      expect { user.connect_to(other_user) }.to(change { other_user.reload.connection_token })
    end
  end
end
