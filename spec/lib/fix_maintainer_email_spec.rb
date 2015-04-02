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
  end

  # it 'should fix " dot " to "."'
  #
  # it 'should fix ".ru" to ".org"' do
  #   expect(FixMaintainerEmail.new(icesik@altlinux.ru).execute)
  #     .to eq('icesik@altlinux.org')
  # end
  #
  # it 'should fix ".net" to ".org"' do
  #   expect(FixMaintainerEmail.new(icesik@altlinux.net).execute)
  #     .to eq('icesik@altlinux.org')
  # end
  #
  # it 'should fix ".com" to ".org"' do
  #   expect(FixMaintainerEmail.new(icesik@altlinux.com).execute)
  #       .to eq('icesik@altlinux.org')
  # end


  # it 'should fix maintainer login' do
  #   expect(fix_maintainer_email('icesik at altlinux.ru')).to eq('icesik@altlinux.org')
  #   expect(fix_maintainer_email('icesik at altlinux.ru')).to eq('icesik@altlinux.org')
  #   expect(fix_maintainer_email('icesik at altlinux.org')).to eq('icesik@altlinux.org')
  #   expect(fix_maintainer_email('icesik at altlinux.net')).to eq('icesik@altlinux.org')
  #   expect(fix_maintainer_email('icesik at altlinux.com')).to eq('icesik@altlinux.org')
  #   expect(fix_maintainer_email('icesik at altlinux dot org')).to eq('icesik@altlinux.org')
  #   expect(fix_maintainer_email('icesik at altlinux dot ru')).to eq('icesik@altlinux.org')
  #   expect(fix_maintainer_email('icesik at altlinux dot net')).to eq('icesik@altlinux.org')
  #   expect(fix_maintainer_email('icesik at altlinux dot com')).to eq('icesik@altlinux.org')
  #   expect(fix_maintainer_email('icesik@altlinux.ru')).to eq('icesik@altlinux.org')
  #   expect(fix_maintainer_email('icesik@altlinux.net')).to eq('icesik@altlinux.org')
  #   expect(fix_maintainer_email('icesik@altlinux.com')).to eq('icesik@altlinux.org')
  #   expect(fix_maintainer_email('ruby at packages.altlinux.org')).to eq('ruby@packages.altlinux.org')
  #   expect(fix_maintainer_email('ruby at packages.altlinux.ru')).to eq('ruby@packages.altlinux.org')
  #   expect(fix_maintainer_email('ruby at packages.altlinux.net')).to eq('ruby@packages.altlinux.org')
  #   expect(fix_maintainer_email('ruby at packages.altlinux.com')).to eq('ruby@packages.altlinux.org')
  #   expect(fix_maintainer_email('ruby@packages.altlinux.ru')).to eq('ruby@packages.altlinux.org')
  #   expect(fix_maintainer_email('ruby@packages.altlinux.net')).to eq('ruby@packages.altlinux.org')
  #   expect(fix_maintainer_email('ruby@packages.altlinux.com')).to eq('ruby@packages.altlinux.org')
  # end

end