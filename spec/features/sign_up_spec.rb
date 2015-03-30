require 'rails_helper'

describe 'Sign up' do
  it 'should successfully sign up user and confirm them' do
    create(:branch, name: 'Sisyphus', vendor: 'ALT Linux')

    visit '/'
    click_link 'Sign up'

    fill_in('Email', with: 'me@example.com')
    fill_in('Password', with: 'password')
    fill_in('Password confirmation', with: 'password')

    click_button 'Sign up'

    expect(page).to have_content('A message with a confirmation link has been sent to your email address. Please open the link to activate your account.')

    open_email('me@example.com')

    expect(current_email).to have_content('Confirm my account')
    current_email.click_link 'Confirm my account'
    expect(page).to have_content('Your account was successfully confirmed.')
  end
end
