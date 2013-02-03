# encoding: utf-8

require 'spec_helper'

describe MaintainerTeam do
  # describe 'Associations' do
  #   it { should have_many :teams }
  #   it { should have_many :gears }
  #   it { should have_many :ftbfs }
  # end

  describe 'Validation' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :email }
    it { should validate_presence_of :login }
  end

  it 'should validate_uniqueness_of :login' do
    MaintainerTeam.create!(name: 'Ruby Team',
                           email: 'ruby@packages.altlinux.org',
                           login: 'ruby')
    should validate_uniqueness_of :login
  end

  it 'should return Maintainer.login on .to_param' do
    MaintainerTeam.create!(name: 'Ruby Team',
                           email: 'ruby@packages.altlinux.org',
                           login: 'ruby').to_param.should == 'ruby'
  end

  it 'should deny change email' do
    maintainer_team = MaintainerTeam.create!(name: 'Ruby Team',
                                             email: 'ruby@packages.altlinux.org',
                                             login: 'ruby')
    maintainer_team.email = 'not_ruby@packages.altlinux.org'
    maintainer_team.save.should be_false
  end

  it 'should deny change login' do
    maintainer_team = MaintainerTeam.create!(name: 'Ruby Team',
                                             email: 'ruby@packages.altlinux.org',
                                             login: 'ruby')
    maintainer_team.login = 'not_ruby'
    maintainer_team.save.should be_false
  end

  it 'should deny change name' do
    maintainer_team = MaintainerTeam.create!(name: 'Ruby Team',
                                             email: 'ruby@packages.altlinux.org',
                                             login: 'ruby')
    maintainer_team.name = 'Not Ruby Team'
    maintainer_team.save.should be_false
  end

  it 'should return true if MaintainerTeam exists' do
    MaintainerTeam.create!(name: 'Ruby Maintainers Team',
                           email: 'ruby@packages.altlinux.org',
                           login: 'ruby')
    MaintainerTeam.team_exists?('ruby').should be_true
  end

  it 'should return false if Maintainer team not exists' do
    MaintainerTeam.team_exists?('non_exists_team').should be_false
  end

  it 'should downcase login before checking for exists' do
    MaintainerTeam.create!(name: 'Ruby Maintainers Team',
                           email: 'ruby@packages.altlinux.org',
                           login: 'ruby')
    MaintainerTeam.team_exists?('RUBY').should be_true
  end
end
