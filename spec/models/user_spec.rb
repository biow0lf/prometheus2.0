require 'spec_helper'

describe User do
  it 'should return login on User.login' do
    User.new(email: 'icesik@altlinux.org').login.should == 'icesik'
  end

  it 'should return true for @altlinux.org emails' do
    User.new(email: 'icesik@altlinux.org').is_alt_team?.should be_true
  end

  it 'should return true for @altlinux.ru emails' do
    User.new(email: 'icesik@altlinux.ru').is_alt_team?.should be_true
  end

  it 'should return false for non altlinux team member' do
    User.new(email: 'user@email.com').is_alt_team?.should be_false
  end

  it 'should deny change email' do
    user = User.create!(email: 'user@email.com',
                        password: 'password',
                        password_confirmation: 'password')
    user.confirmed_at = Time.zone.now
    user.save!
    user.email = 'icesik@altlinux.org'
    user.save.should be_false
  end
end
