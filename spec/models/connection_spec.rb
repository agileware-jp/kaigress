# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Connection, type: :model do
  describe '#from_and_to_are_different' do
    let(:user) { create :user }

    it 'cannot create a connection between one and the same user' do
      connection = build :connection, from: user, to: user
      expect(connection).to be_invalid
    end
  end
end
