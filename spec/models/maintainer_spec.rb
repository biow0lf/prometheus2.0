# frozen_string_literal: true

require 'rails_helper'

describe Maintainer do
  it { should be_a(ApplicationRecord) }

  context 'Associations' do
    it { should have_many(:teams) }

    it { should have_many(:gears) }

    it { should have_many(:ftbfs) }
  end

  context 'Validation' do
    it { should validate_presence_of(:name) }

    it { should validate_presence_of(:email) }

    it { should validate_presence_of(:login) }
  end

  it 'should validate_uniqueness_of :login' do
    Maintainer.create!(name: 'Igor Zubkov',
                       email: 'icesik@altlinux.org',
                       login: 'icesik')
    should validate_uniqueness_of :login
  end

  it 'should return Maintainer.login on .to_param' do
    expect(Maintainer.new(login: 'icesik').to_param).to eq('icesik')
  end

  it 'should deny change email' do
    maintainer = Maintainer.create!(name: 'Igor Zubkov',
                                    email: 'icesik@altlinux.org',
                                    login: 'icesik')
    maintainer.email = 'ldv@altlinux.org'
    expect(maintainer.save).to eq(false)
  end

  it 'should deny change login' do
    maintainer = Maintainer.create!(name: 'Igor Zubkov',
                                    email: 'icesik@altlinux.org',
                                    login: 'icesik')
    maintainer.login = 'ldv'
    expect(maintainer.save).to eq(false)
  end

  it 'should deny change name' do
    maintainer = Maintainer.create!(name: 'Igor Zubkov',
                                    email: 'icesik@altlinux.org',
                                    login: 'icesik')
    maintainer.name = 'Dmitry V. Levin'
    expect(maintainer.save).to eq(false)
  end

  it 'should return true if Maintainer exists' do
    Maintainer.create!(name: 'Igor Zubkov',
                       email: 'icesik@altlinux.org',
                       login: 'icesik')
    expect(Maintainer.login_exists?('icesik')).to eq(true)
  end

  it 'should return false if Maintainer not exists' do
    expect(Maintainer.login_exists?('ice')).to eq(false)
  end

  it 'should downcase login before checking for exists' do
    Maintainer.create!(name: 'Igor Zubkov',
                       email: 'icesik@altlinux.org',
                       login: 'icesik')
    expect(Maintainer.login_exists?('ICESIK')).to eq(true)
  end

  it 'should create one Maintainer' do
    expect {
      Maintainer.import('Igor Zubkov <icesik@altlinux.org>')
    }.to change(Maintainer, :count).by(1)
  end

  it 'should not create Maintainer if Maintainer already exists' do
    Maintainer.import('Igor Zubkov <icesik@altlinux.org>')
    expect {
      Maintainer.import('Igor Zubkov <icesik@altlinux.org>')
    }.to_not change(Maintainer, :count)
  end

  it 'should create new Maintainer team' do
    expect {
      Maintainer.import('Ruby Maintainers Team <ruby@packages.altlinux.org>')
    }.to change(MaintainerTeam, :count).by(1)
  end

  it 'should not create new Maintainer team' do
    Maintainer.import('Ruby Maintainers Team <ruby@packages.altlinux.org>')
    expect {
      Maintainer.import('Ruby Maintainers Team <ruby@packages.altlinux.org>')
    }.to_not change(MaintainerTeam, :count)
  end
end
