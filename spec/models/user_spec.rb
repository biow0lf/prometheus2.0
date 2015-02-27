require 'rails_helper'

describe User do
  it 'should return login on #login' do
    expect(User.new(email: 'icesik@altlinux.org').login).to eq('icesik')
  end

  it 'should return true for @altlinux.org emails' do
    expect(User.new(email: 'icesik@altlinux.org').is_alt_team?).to eq(true)
  end

  it 'should return true for @altlinux.ru emails' do
    expect(User.new(email: 'icesik@altlinux.ru').is_alt_team?).to eq(true)
  end

  it 'should return false for non altlinux team member' do
    expect(User.new(email: 'user@email.com').is_alt_team?).to eq(false)
  end

  it 'should deny change email' do
    user = User.create!(email: 'user@email.com',
                        password: 'password',
                        password_confirmation: 'password')
    user.confirmed_at = Time.zone.now
    user.save!
    user.email = 'icesik@altlinux.org'
    expect(user.save).to eq(false)
  end
end
