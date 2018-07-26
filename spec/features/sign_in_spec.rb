# frozen_string_literal: true

require 'rails_helper'

describe 'Sign in' do
  it 'should successfully sign in user' do
    create(:branch, name: 'Sisyphus', vendor: 'ALT Linux')
    email = 'me@example.com'
    password = 'password'
    create(:user, :confirmed, email: email, password: password)

    visit '/'
    click_link 'Sign in'

    fill_in('Email', with: email)
    fill_in('Password', with: password)

    click_button 'Sign in'
    expect(page).to have_content('Signed in successfully.')
    expect(page).to have_content('Welcome, me@example.com!')
  end
end
