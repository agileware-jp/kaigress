require 'rails_helper'

RSpec.describe User, type: :model do
  describe '.smallest_teams' do
    subject { User.smallest_teams }

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
end
