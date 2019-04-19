# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Connection, type: :model do
  describe 'Validations' do
    describe '#from_and_to_are_different' do
      let(:user) { create :user }

      it 'cannot create a connection between one and the same user' do
        expect(user.connect_to(user)).to be_invalid
      end
    end

    describe 'Prevent same connections' do
      let(:user) { create :user }
      let(:other_user) { create :user }

      before do
        user.connect_to(other_user)
      end

      it 'cannot create exactly the same connection' do
        expect(user.connect_to(other_user)).to(be_invalid)
      end

      it 'cannot create the opposite connection' do
        expect(other_user.connect_to(user)).to(be_invalid)
      end
    end

    describe 'Restrict same team' do
      subject { user.connect_to(other_user) }
      let(:user) { create :user, team: :red }

      context 'in same team' do
        let(:other_user) { create :user, team: :red }
        it { is_expected.to be_valid }
      end

      context 'in other team' do
        let(:other_user) { create :user, team: :blue }
        it { is_expected.to be_invalid }
      end
    end
  end
end
