# frozen_string_literal: true

require 'rails_helper'

def register
  visit register_path
  fill_in 'Nickname', with: 'bob'
  click_button
end

RSpec.feature 'Connection', type: :feature, js: true do
  describe 'Connection status' do
    let(:other_user) { create :user, team: User.last.team }

    before do
      register
      visit connect_path(uuid: uuid, connection_token: connection_token)
    end

    context 'Connection successful' do
      let(:uuid) { other_user.uuid }
      let(:connection_token) { other_user.connection_token }

      it 'shows success message' do
        expect(page).to have_text 'Connected with'
      end

      context 'when trying to connect one more time' do
        it 'shows fail message' do
          visit connect_path(uuid: uuid, connection_token: other_user.reload.connection_token)
          expect(page).to have_text 'Connection failed'
        end
      end
    end

    context 'Token is different' do
      let(:uuid) { other_user.uuid }
      let(:connection_token) { 'blabla' }

      it 'shows fail message' do
        expect(page).to have_text 'Connection failed'
      end
    end
  end
end
