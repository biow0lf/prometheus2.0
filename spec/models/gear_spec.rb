# frozen_string_literal: true

require 'rails_helper'

describe Gear do
  it { should be_a(ApplicationRecord) }

  context 'Associations' do
    it { should belong_to(:maintainer) }

    it { should belong_to(:srpm) }
  end

  context 'Validation' do
    it { should validate_presence_of(:repo) }

    it { should validate_presence_of(:lastchange) }
  end

  # it 'should import gear repos' do
  #   Branch.delete_all # TODO: check why this needed?
  #   branch = create(:branch, name: 'Sisyphus', vendor: 'ALT Linux')
  #
  #   group0 = Group.create!(name: 'System', branch_id: branch.id)
  #   group = Group.create!(name: 'Servers', branch_id: branch.id)
  #   group.move_to_child_of(group0)
  #
  #   Maintainer.create!(name: 'Igor Zubkov',
  #                      email: 'icesik@altlinux.org',
  #                      login: 'icesik')
  #
  #   Srpm.create!(branch_id: branch.id,
  #                name: 'pulseaudio',
  #                version: '1.1',
  #                release: 'alt1.1',
  #                summary: 'PulseAudio is a networked sound server',
  #                description: 'long description',
  #                group_id: group.id,
  #                groupname: 'System/Servers',
  #                license: 'LGPL',
  #                url: 'http://pulseaudio.org/',
  #                size: 10_482_200,
  #                filename: 'pulseaudio-1.1-alt1.1.src.rpm',
  #                md5: '602df8c1227b9b5ddf2ba87efb081007',
  #                buildtime: '2011-11-17 13:48:29 UTC')
  #
  #   page = File.read('spec/data/people-packages-list')
  #   url = 'http://git.altlinux.org/people-packages-list'
  #   FakeWeb.register_uri(:get, url, response: page)
  #
  #   expect { Gear.update_gitrepos(url) }.to change(Gear, :count).by(1)
  # end
end
