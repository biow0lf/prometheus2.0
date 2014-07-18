require 'spec_helper'

describe Maintainer, :type => :model do
  describe 'Associations' do
    it { is_expected.to have_many :teams }
    it { is_expected.to have_many :gears }
    it { is_expected.to have_many :ftbfs }
  end

  describe 'Validation' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_presence_of :email }
    it { is_expected.to validate_presence_of :login }
  end

  it 'should validate_uniqueness_of :login' do
    Maintainer.create!(name: 'Igor Zubkov',
                       email: 'icesik@altlinux.org',
                       login: 'icesik')
    is_expected.to validate_uniqueness_of :login
  end

  it 'should return Maintainer.login on .to_param' do
    expect(Maintainer.new(login: 'icesik').to_param).to eq('icesik')
  end

  it 'should deny change email' do
    maintainer = Maintainer.create!(name: 'Igor Zubkov',
                                    email: 'icesik@altlinux.org',
                                    login: 'icesik')
    maintainer.email = 'ldv@altlinux.org'
    expect(maintainer.save).to be_falsey
  end

  it 'should deny change login' do
    maintainer = Maintainer.create!(name: 'Igor Zubkov',
                                    email: 'icesik@altlinux.org',
                                    login: 'icesik')
    maintainer.login = 'ldv'
    expect(maintainer.save).to be_falsey
  end

  it 'should deny change name' do
    maintainer = Maintainer.create!(name: 'Igor Zubkov',
                                    email: 'icesik@altlinux.org',
                                    login: 'icesik')
    maintainer.name = 'Dmitry V. Levin'
    expect(maintainer.save).to be_falsey
  end

  it 'should return true if Maintainer exists' do
    Maintainer.create!(name: 'Igor Zubkov',
                       email: 'icesik@altlinux.org',
                       login: 'icesik')
    expect(Maintainer.login_exists?('icesik')).to be_truthy
  end

  it 'should return false if Maintainer not exists' do
    expect(Maintainer.login_exists?('ice')).to be_falsey
  end

  it 'should downcase login before checking for exists' do
    Maintainer.create!(name: 'Igor Zubkov',
                       email: 'icesik@altlinux.org',
                       login: 'icesik')
    expect(Maintainer.login_exists?('ICESIK')).to be_truthy
  end

  it 'should create one Maintainer' do
    expect {
      Maintainer.import('Igor Zubkov <icesik@altlinux.org>')
    }.to change { Maintainer.count }.from(0).to(1)
  end

  it 'should not create Maintainer if Maintainer already exists' do
    2.times { Maintainer.import('Igor Zubkov <icesik@altlinux.org>') }
    expect(Maintainer.count).to eq(1)
  end

  it 'should create new Maintainer team' do
    expect {
      Maintainer.import('Ruby Maintainers Team <ruby@packages.altlinux.org>')
    }.to change { MaintainerTeam.count }.from(0).to(1)
  end

  it 'should not create new Maintainer team' do
    2.times { Maintainer.import('Ruby Maintainers Team <ruby@packages.altlinux.org>') }
    expect(MaintainerTeam.count).to eq(1)
  end
end
