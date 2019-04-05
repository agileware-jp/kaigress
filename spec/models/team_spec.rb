# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Team, type: :model do
  describe '.smallest_teams' do
    subject { Team.smallest_teams }

    context 'No Members' do
      it { is_expected.to contain_exactly(:red, :green, :blue) }
    end

    context 'Two teams have lowest members' do
      before do
        create :user, team: :red
      end

      it { is_expected.to contain_exactly(:green, :blue) }
    end

    context 'One teams has lowest members' do
      before do
        create :user, team: :red
        create :user, team: :blue
      end

      it { is_expected.to contain_exactly(:green) }
    end

    context 'All teams have lowest members' do
      before do
        create :user, team: :red
        create :user, team: :blue
        create :user, team: :green
      end

      it { is_expected.to contain_exactly(:red, :green, :blue) }
    end
  end

  describe '.connections_of' do
    subject { Team.connections_of(:red) }

    context 'When there is no connection' do
      it { is_expected.to be_empty }
    end

    context 'When there is connections' do
      let!(:red_connection) {
        create :connection, from: create(:user, team: :red), to: create(:user, team: :red)
      }

      before do
        create :connection, from: create(:user, team: :blue), to: create(:user, team: :blue)
      end

      it { is_expected.to contain_exactly(red_connection) }
    end
  end
end
