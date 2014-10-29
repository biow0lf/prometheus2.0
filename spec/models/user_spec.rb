require 'spec_helper'

describe User, type: :model do
  it 'should return login on User.login' do
    expect(User.new(email: 'icesik@altlinux.org').login).to eq('icesik')
  end

  it 'should return true for @altlinux.org emails' do
    expect(User.new(email: 'icesik@altlinux.org').is_alt_team?).to be_truthy
  end

  it 'should return true for @altlinux.ru emails' do
    expect(User.new(email: 'icesik@altlinux.ru').is_alt_team?).to be_truthy
  end

  it 'should return false for non altlinux team member' do
    expect(User.new(email: 'user@email.com').is_alt_team?).to be_falsey
  end

  it 'should deny change email' do
    user = User.create!(email: 'user@email.com',
                        password: 'password',
                        password_confirmation: 'password')
    user.confirmed_at = Time.zone.now
    user.save!
    user.email = 'icesik@altlinux.org'
    expect(user.save).to be_falsey
  end
end
