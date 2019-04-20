# frozen_string_literal: true

require 'rails_helper'

def register
  visit register_path
  fill_in 'Nickname', with: 'bob'
  click_button
end

def expect_to_be_on_user_page
  expect(page).to have_text 'YOUR QR-CODE'
end

RSpec.feature 'Registration', type: :feature, js: true do
  before do
    visit register_path
  end

  it 'can register' do
    fill_in 'Nickname', with: 'bob'
    click_button
    expect_to_be_on_user_page
  end

  it 'registers to user info when trying to register again' do
    fill_in 'Nickname', with: 'bob'
    click_button

    visit register_path

    expect_to_be_on_user_page
  end
end

RSpec.feature 'User Page', type: :feature, js: true do
  context 'After having registered' do
    before do
      register
    end

    it 'shows the user page' do
      visit root_path

      expect_to_be_on_user_page
    end
  end

  context 'without registering' do
    it 'shows error' do
      visit root_path

      expect(page).to have_text 'You are not participating in Kaigress'
    end
  end
end

RSpec.feature 'Connection', type: :feature, js: true do
  describe 'Connection status' do
    let(:other_user) { create :user, team: User.last.team }
    let(:uuid) { other_user.uuid }

    before do
      register
      visit connect_path(uuid: uuid)
    end

    context 'Connection successful' do
      it 'shows success message' do
        expect(page).to have_text 'Connected with'
      end

      context 'when trying to connect one more time' do
        it 'shows fail message' do
          visit connect_path(uuid: uuid)
          expect(page).to have_text 'You are already connected'
        end
      end
    end

    context 'Trying to connect to oneself' do
      let(:uuid) { User.last.uuid }

      it 'shows error message' do
        expect(page).to have_text 'You cannot connect to yourself'
      end
    end
  end
end
