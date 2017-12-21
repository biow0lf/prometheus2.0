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
    it 'should return login extracted from email' do
      text = 'Igor Zubkov <icesik@altlinux.org> 1.0-alt5'
      changelog = Changelog.new(changelogname: text)
      expect(changelog).to receive(:email).twice.and_return('icesik@altlinux.org')
      expect(changelog.login).to eq('icesik')
    end

    it 'should return nil if email is nil' do
      text = 'Igor Zubkov'
      changelog = Changelog.new(changelogname: text)
      expect(changelog).to receive(:email).and_return(nil)
      expect(changelog.login).to eq(nil)
    end
  end

  it 'should import changelogs' do
    branch = create(:branch)
    group = create(:group, branch_id: branch.id)
    srpm = create(:srpm, branch_id: branch.id, group_id: group.id)

    file = 'openbox-3.4.11.1-alt1.1.1.src.rpm'
    expect(Changelog).to receive(:`).with("export LANG=C && rpm -qp --queryformat='[%{CHANGELOGTIME}\n**********\n%{CHANGELOGNAME}\n**********\n%{CHANGELOGTEXT}\n**********\n]' #{file}").and_return("1312545600\n**********\nMykola Grechukh <gns@altlinux.ru> 3.5.0-alt1\n**********\n3.4.11.1 -> 3.5.0\n**********\n1312545600\n**********\nMykola Grechukh <gns@altlinux.ru> 3.5.0-alt1\n**********\n3.4.11.1 -> 3.5.0\n**********\n")

    expect { Changelog.import(file, srpm) }
      .to change(Changelog, :count).by(2)
  end
end
