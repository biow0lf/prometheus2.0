require 'spec_helper'

describe MaintainerTeam, :type => :model do
  # describe 'Associations' do
  #   it { should have_many :teams }
  #   it { should have_many :gears }
  #   it { should have_many :ftbfs }
  # end

  describe 'Validation' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :email }
    it { is_expected.to validate_presence_of :login }
  end

  it 'should validate_uniqueness_of :login' do
    MaintainerTeam.create!(name: 'Ruby Team',
                           email: 'ruby@packages.altlinux.org',
                           login: 'ruby')
    is_expected.to validate_uniqueness_of :login
  end

  it 'should return Maintainer.login on .to_param' do
    expect(MaintainerTeam.new(login: 'ruby').to_param).to eq('ruby')
  end

  it 'should deny change email' do
    maintainer_team = MaintainerTeam.create!(name: 'Ruby Team',
                                             email: 'ruby@packages.altlinux.org',
                                             login: 'ruby')
    maintainer_team.email = 'not_ruby@packages.altlinux.org'
    expect(maintainer_team.save).to be_falsey
  end

  it 'should deny change login' do
    maintainer_team = MaintainerTeam.create!(name: 'Ruby Team',
                                             email: 'ruby@packages.altlinux.org',
                                             login: 'ruby')
    maintainer_team.login = 'not_ruby'
    expect(maintainer_team.save).to be_falsey
  end

  it 'should deny change name' do
    maintainer_team = MaintainerTeam.create!(name: 'Ruby Team',
                                             email: 'ruby@packages.altlinux.org',
                                             login: 'ruby')
    maintainer_team.name = 'Not Ruby Team'
    expect(maintainer_team.save).to be_falsey
  end

  it 'should return true if MaintainerTeam exists' do
    MaintainerTeam.create!(name: 'Ruby Maintainers Team',
                           email: 'ruby@packages.altlinux.org',
                           login: 'ruby')
    expect(MaintainerTeam.team_exists?('ruby')).to be_truthy
  end

  it 'should return false if Maintainer team not exists' do
    expect(MaintainerTeam.team_exists?('non_exists_team')).to be_falsey
  end

  it 'should downcase login before checking for exists' do
    MaintainerTeam.create!(name: 'Ruby Maintainers Team',
                           email: 'ruby@packages.altlinux.org',
                           login: 'ruby')
    expect(MaintainerTeam.team_exists?('RUBY')).to be_truthy
  end
end
