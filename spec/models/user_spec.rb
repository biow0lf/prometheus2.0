# encoding: utf-8

require 'spec_helper'

describe User do
  it 'should return login on User.login' do
    user = User.create!(email: 'icesik@altlinux.org',
                        password: 'password',
                        password_confirmation: 'password')
    user.confirmed_at = Time.zone.now
    user.save!
    user.login.should == 'icesik'
  end

  it 'should return true for @altlinux.org emails' do
    user = User.create!(email: 'icesik@altlinux.org',
                        password: 'password',
                        password_confirmation: 'password')
    user.confirmed_at = Time.zone.now
    user.save!
    user.is_alt_team?.should be_true
  end

  it 'should return true for @altlinux.ru emails' do
    user = User.create!(email: 'icesik@altlinux.ru',
                        password: 'password',
                        password_confirmation: 'password')
    user.confirmed_at = Time.zone.now
    user.save!
    user.is_alt_team?.should be_true
  end

  it 'should return false for non altlinux team member' do
    user = User.create!(email: 'user@email.com',
                        password: 'password',
                        password_confirmation: 'password')
    user.confirmed_at = Time.zone.now
    user.save!
    user.is_alt_team?.should be_false
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
