# frozen_string_literal: true

require 'rails_helper'

describe 'Recover password' do
  it 'should recover password' do
    create(:branch, name: 'Sisyphus', vendor: 'ALT Linux', slug: "sisyphus")
    user = create(:user, :confirmed,
                  email: 'me@example.com',
                  password: 'password')

    visit '/'

    click_link 'Sign in'
    click_link 'Forgot your password?'
    fill_in('Email', with: user.email)
    click_button('Send me reset password instructions')

    text = I18n.t('devise.passwords.send_instructions')
    expect(page).to have_content(text)

    open_email('me@example.com')

    expect(current_email.subject).to eq('Reset password instructions')
    expect(current_email.body).to include('Change my password')

    current_email.click_link 'Change my password'
    fill_in('New password', with: 'mynewpassword')
    fill_in('Confirm new password', with: 'mynewpassword')
    click_button 'Change my password'

    text = I18n.t('devise.passwords.updated')
    expect(page).to have_content(text)
    expect(page).to have_content('Welcome, me@example.com!')
  end
end
