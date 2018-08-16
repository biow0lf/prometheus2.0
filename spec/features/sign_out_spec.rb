# frozen_string_literal: true

require 'rails_helper'

include Warden::Test::Helpers

describe 'Sign out' do
  it 'should successfully sign out user' do
    create(:branch, name: 'Sisyphus', vendor: 'ALT Linux', slug: "sisyphus")
    user = create(:user, :confirmed)
    login_as user

    visit '/'

    click_link 'Sign out'
    expect(page).to have_content('Signed out successfully.')
  end
end
