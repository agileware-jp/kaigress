require 'rails_helper'

RSpec.feature 'Connection', type: :feature do
  describe 'Connection status' do
    let(:user) { create :user }
    let(:other_user) { create :user }

    context 'Connection successful' do
      it 'shows success message' do
      end
    end

    context 'Connection failed' do
    end
  end
end
