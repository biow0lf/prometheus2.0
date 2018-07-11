# frozen_string_literal: true

require 'rails_helper'

describe Changelog do
  it { should be_a(ApplicationRecord) }

  context 'Associations' do
    it { should belong_to(:srpm) }
  end

  context 'Validation' do
    it { should validate_presence_of(:changelogtime) }

    it { should validate_presence_of(:changelogname) }

    it { should validate_presence_of(:changelogtext) }
  end

  context '#parse_changelogname' do
    context 'should fix " at " to "@"' do
      subject { described_class.new(changelogname: 'User <icesik at altlinux.org>') }

      it { expect(subject.email).to eq('icesik@altlinux.org') }
    end

    context 'should fix " dot " to "."' do
      subject { described_class.new(changelogname: 'User <icesik@altlinux dot org>') }

      it { expect(subject.email).to eq('icesik@altlinux.org') }
    end

    context 'should fix "altlinux.ru" to "altlinux.org"' do
      subject { described_class.new(changelogname: 'User <icesik@altlinux.ru>') }

      it { expect(subject.email).to eq('icesik@altlinux.org') }
    end

    context 'should fix "altlinux.net" to "altlinux.org"' do
      subject { described_class.new(changelogname: 'User <icesik@altlinux.ru>') }

      it { expect(subject.email).to eq('icesik@altlinux.org') }
    end

    context 'should fix "altlinux.com" to "altlinux.org"' do
      subject { described_class.new(changelogname: 'User <icesik@altlinux.ru>') }

      it { expect(subject.email).to eq('icesik@altlinux.org') }
    end

    context 'should fix UPPERCASE values' do
      subject { described_class.new(changelogname: 'User <ICESIK@ALTLINUX.RU>') }

      it { expect(subject.email).to eq('icesik@altlinux.org') }
    end

    context 'should fix everything' do
      subject { described_class.new(changelogname: 'User <ICESIK AT ALTLINUX DOT RU>') }

      it { expect(subject.email).to eq('icesik@altlinux.org') }
    end

    context 'should fix everything in packages domain' do
      subject { described_class.new(changelogname: 'User <RUBY AT PACKAGES DOT ALTLINUX DOT RU>') }

      it { expect(subject.email).to eq('ruby@packages.altlinux.org') }
    end
  end

  context '#email' do
    it 'should return email' do
      text = 'Igor Zubkov <icesik@altlinux.org> 1.0-alt5'
      expect(Changelog.new(changelogname: text).email)
        .to eq('icesik@altlinux.org')
    end

    it 'should return nil if changelogname in wrong format' do
      text = 'Igor Zubkov'
      expect(Changelog.new(changelogname: text).email).to eq(nil)
    end
  end

  context '#login' do
    context 'should return login extracted from email' do
      subject { Changelog.new(changelogname: 'Igor Zubkov <icesik@altlinux.org> 1.0-alt5') }

      it { expect(subject.login).to eq('icesik') }
    end

    context 'should return nil if email is nil' do
      subject { Changelog.new(changelogname: 'Igor Zubkov') }

      it { expect(subject.email).to be_nil }
      it { expect(subject.login).to be_nil }
    end
  end

  it 'should import changelogs' do
    branch = create(:branch)
    group = create(:group, branch_id: branch.id)
    srpm = create(:srpm, branch_id: branch.id, group_id: group.id)

    file = 'openbox-3.4.11.1-alt1.1.1.src.rpm'
    expect(Changelog).to receive(:`).with("export LANG=C && rpm -qp --queryformat='[%{CHANGELOGTIME}\n**********\n%{CHANGELOGNAME}\n**********\n%{CHANGELOGTEXT}\n**********\n]' #{ file }").and_return("1312545600\n**********\nMykola Grechukh <gns@altlinux.ru> 3.5.0-alt1\n**********\n3.4.11.1 -> 3.5.0\n**********\n1312545600\n**********\nMykola Grechukh <gns@altlinux.ru> 3.5.0-alt1\n**********\n3.4.11.1 -> 3.5.0\n**********\n")

    expect { Changelog.import(file, srpm) }
      .to change(Changelog, :count).by(2)
  end
end
