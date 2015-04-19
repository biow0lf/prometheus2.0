require 'rails_helper'

describe 'Source RPM info API' do
  before(:each) do
    @branch = create(:branch, name: 'Sisyphus')
    @group = create(:group, name: 'Graphical desktop/Other')
    @maintainer = create(:maintainer, login: 'icesik')

    @srpm = create(
      :srpm,
      branch: @branch,
      group: @group,
      groupname: @group.name,
      name: 'openbox',
      version: '3.4.11.1',
      release: 'alt1.1.1',
      epoch: nil,
      summary: 'short description',
      description: 'long description',
      license: 'GPLv2+',
      url: 'http://openbox.org/',
      size: 831_617,
      filename: 'openbox-3.4.11.1-alt1.1.1.src.rpm',
      md5: 'f87ff0eaa4e16b202539738483cd54d1',
      buildtime: '2010-11-24T23:58:02.000Z',
      vendor: 'ALT Linux Team',
      distribution: 'ALT Linux'
    )
    key = "#{ @branch.name }:#{ @srpm.name }:acls"
    Redis.current.sadd(key, @maintainer.login)
  end

  it 'does validate values' do
    get "/en/#{ @branch.name }/srpms/#{ @srpm.name }", format: :json

    expect_json(
      branch: @branch.name,
      name: 'openbox',
      version: '3.4.11.1',
      release: 'alt1.1.1',
      epoch: nil,
      summary: 'short description',
      description: 'long description',
      group: 'Graphical desktop/Other',
      license: 'GPLv2+',
      url: 'http://openbox.org/',
      size: 831_617,
      filename: 'openbox-3.4.11.1-alt1.1.1.src.rpm',
      md5: 'f87ff0eaa4e16b202539738483cd54d1',
      buildtime: '2010-11-24T23:58:02.000Z',
      vendor: 'ALT Linux Team',
      distribution: 'ALT Linux',
      repocop: 'skip',
      acls: 'icesik'
    )
  end

  it 'does validate types' do
    get "/en/#{ @branch.name }/srpms/#{ @srpm.name }", format: :json

    expect_json_types(
      branch: :string,
      name: :string,
      version: :string,
      release: :string,
      epoch: :int_or_null,
      summary: :string,
      description: :string,
      group: :string,
      license: :string,
      url: :string,
      size: :int,
      filename: :string,
      md5: :string,
      buildtime: :date,
      vendor: :string,
      distribution: :string,
      repocop: :string,
      acls: :string
    )
  end
end
