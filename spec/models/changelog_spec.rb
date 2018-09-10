# frozen_string_literal: true

require 'rails_helper'

describe Changelog do
  it { should be_a(ApplicationRecord) }

  context 'Associations' do
    it { should belong_to(:package) }
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
    branch = create(:branch, :with_paths)
    group = create(:group, branch: branch)
    srpm = create(:srpm, branch: branch, group: group)

    file = './spec/data/catpkt-1.0-alt5.src.rpm'

    expect { Changelog.import_from(Rpm::Base.new(file), srpm.package) }
      .to change(Changelog, :count).by(5)
  end
end
