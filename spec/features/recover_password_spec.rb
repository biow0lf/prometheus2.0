require 'rails_helper'

describe 'Recover password' do
  it 'should recover password' do
    create(:branch, name: 'Sisyphus', vendor: 'ALT Linux')
    user = create(:user_confirmed, email: 'me@example.com', password: 'password')

    visit '/'

    click_link 'Sign in'
    click_link 'Forgot your password?'
    fill_in('Email', with: 'me@example.com')
    click_button('Send me reset password instructions')

    expect(page).to have_content('You will receive an email with instructions on how to reset your password in a few minutes.')

    open_email('me@example.com')

    expect(current_email.subject).to eq('Reset password instructions')
    expect(current_email.body).to include('Change my password')

    current_email.click_link 'Change my password'
    fill_in('New password', with: 'mynewpassword')
    fill_in('Confirm new password', with: 'mynewpassword')
    click_button 'Change my password'

    expect(page).to have_content('Your password was changed successfully. You are now signed in.')
    expect(page).to have_content('Welcome, me@example.com!')
  end
end
