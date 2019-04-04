# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Connection, type: :model do
  describe 'Validations' do
    describe '#from_and_to_are_different' do
      let(:user) { create :user }

      it 'cannot create a connection between one and the same user' do
        connection = build :connection, from: user, to: user
        expect(connection).to be_invalid
      end
    end

    describe 'Prevent same connections' do
      let(:user) { create :user }
      let(:other_user) { create :user }

      before do
        user.connect_to(other_user)
      end

      it 'cannot create exactly the same connection' do
        expect(user.connect_to(other_user)).to(be_falsey)
      end

      it 'cannot create the opposite connection' do
        expect(other_user.connect_to(user)).to(be_falsey)
      end
    end
  end
end
