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

    text = I18n.t('devise.registrations.signed_up_but_unconfirmed')
    expect(page).to have_content(text)

    open_email('me@example.com')

    # TODO: always use I18n.t for strings
    expect(current_email).to have_content('Confirm my account')
    current_email.click_link 'Confirm my account'
    expect(page).to have_content('Your account was successfully confirmed.')
  end
end
