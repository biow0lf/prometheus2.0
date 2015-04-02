require 'rails_helper'

describe FixMaintainerEmail do
  context 'maintainer' do
    it 'should fix " at " to "@"' do
      expect(FixMaintainerEmail.new('icesik at altlinux.org').execute)
        .to eq('icesik@altlinux.org')
    end

    it 'should fix " dot " to "."' do
      expect(FixMaintainerEmail.new('icesik@altlinux dot org').execute)
        .to eq('icesik@altlinux.org')
    end

    it 'should fix "altlinux.ru" to "altlinux.org"' do
      expect(FixMaintainerEmail.new('icesik@altlinux.ru').execute)
        .to eq('icesik@altlinux.org')
    end

    it 'should fix "altlinux.net" to "altlinux.org"' do
      expect(FixMaintainerEmail.new('icesik@altlinux.ru').execute)
        .to eq('icesik@altlinux.org')
    end

    it 'should fix "altlinux.com" to "altlinux.org"' do
      expect(FixMaintainerEmail.new('icesik@altlinux.ru').execute)
        .to eq('icesik@altlinux.org')
    end

    it 'should fix UPPERCASE values' do
      expect(FixMaintainerEmail.new('ICESIK@ALTLINUX.RU').execute)
        .to eq('icesik@altlinux.org')
    end

    it 'should fix everything' do
      expect(FixMaintainerEmail.new('ICESIK AT ALTLINUX DOT RU').execute)
        .to eq('icesik@altlinux.org')
    end
  end

  context 'team' do
    it 'should fix " at " to "@"' do
      expect(FixMaintainerEmail.new('ruby at packages.altlinux.org').execute)
        .to eq('ruby@packages.altlinux.org')
    end

    it 'should fix " dot " to "."' do
      expect(FixMaintainerEmail.new('ruby@packages dot altlinux dot org').execute)
        .to eq('ruby@packages.altlinux.org')
    end

    it 'should fix "altlinux.ru" to "altlinux.org"' do
      expect(FixMaintainerEmail.new('ruby@packages.altlinux.ru').execute)
        .to eq('ruby@packages.altlinux.org')
    end

    it 'should fix "altlinux.net" to "altlinux.org"' do
      expect(FixMaintainerEmail.new('ruby@packages.altlinux.net').execute)
        .to eq('ruby@packages.altlinux.org')
    end

    it 'should fix "altlinux.com" to "altlinux.org"' do
      expect(FixMaintainerEmail.new('ruby@packages.altlinux.com').execute)
        .to eq('ruby@packages.altlinux.org')
    end

    it 'should fix UPPERCASE values' do
      expect(FixMaintainerEmail.new('RUBY@PACKAGES.ALTLINUX.COM').execute)
        .to eq('ruby@packages.altlinux.org')
    end

    it 'should fix everything' do
      expect(FixMaintainerEmail.new('RUBY AT PACKAGES DOT ALTLINUX DOT RU').execute)
        .to eq('ruby@packages.altlinux.org')
    end
  end

  it 'should return nil on nil email' do
    expect(FixMaintainerEmail.new(nil).execute).to eq(nil)
  end
end
