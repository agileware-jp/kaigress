# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#connect_to' do
    let(:user) { create :user, team: :red }
    let(:other_user) { create :user, team: :red }

    it 'creates a connection' do
      expect { user.connect_to(other_user) }.to(change { Connection.count })
    end
  end
end
