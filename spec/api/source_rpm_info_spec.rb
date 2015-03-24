require 'rails_helper'

describe 'Source RPM info API' do
  it 'should validate values' do
    branch = create(:branch, name: 'Sisyphus', vendor: 'ALT Linux')
    group0 = Group.create!(name: 'Graphical desktop', branch_id: branch.id)
    group = Group.create!(name: 'Other', branch_id: branch.id)
    group.move_to_child_of(group0)

    maintainer = create(:maintainer,
                        name: 'Igor Zubkov',
                        email: 'icesik@altlinux.org',
                        login: 'icesik')

    srpm = create(:srpm,
      branch_id: branch.id,
      group_id: group.id,
      name: 'openbox',
      version: '3.4.11.1',
      release: 'alt1.1.1',
      epoch: nil,
      summary: 'short description',
      description: 'long description',
      license: 'GPLv2+',
      url: 'http://openbox.org/',
      size: 831617,
      filename: 'openbox-3.4.11.1-alt1.1.1.src.rpm',
      md5: 'f87ff0eaa4e16b202539738483cd54d1',
      buildtime: '2010-11-24T23:58:02.000Z',
      vendor: 'ALT Linux Team',
      distribution: 'ALT Linux'
    )

    Redis.current.sadd("#{ branch.name }:#{ srpm.name }:acls", maintainer.login)

    get '/en/Sisyphus/srpms/openbox', format: :json

    expect_json({
      branch: branch.name,
      name: 'openbox',
      version: '3.4.11.1',
      release: 'alt1.1.1',
      epoch: nil,
      summary: 'short description',
      description: 'long description',
      group: 'Graphical desktop/Other',
      license: 'GPLv2+',
      url: 'http://openbox.org/',
      size: 831617,
      filename: 'openbox-3.4.11.1-alt1.1.1.src.rpm',
      md5: 'f87ff0eaa4e16b202539738483cd54d1',
      buildtime: '2010-11-24T23:58:02.000Z',
      vendor: 'ALT Linux Team',
      distribution: 'ALT Linux',
      repocop: 'skip',
      acls: 'icesik'
    })
  end
end
