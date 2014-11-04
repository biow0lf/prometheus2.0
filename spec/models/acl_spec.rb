require 'spec_helper'

describe Acl, type: :model do
  before(:each) do
    FactoryGirl.create(:branch)

    page = `cat spec/data/list.packages.sisyphus`
    url = 'http://git.altlinux.org/acl/list.packages.sisyphus'
    FakeWeb.register_uri(:get, url, response: page)

    Acl.update_redis_cache('ALT Linux', 'Sisyphus', url)
  end

  it 'should import and update acls' do
    expect(Redis.current.smembers('Sisyphus:rpm:acls').sort).to eq(%w(ldv at).sort)
    expect(Redis.current.smembers('Sisyphus:maintainers:ldv')).to eq(%w(rpm))
    expect(Redis.current.smembers('Sisyphus:maintainers:at')).to eq(%w(rpm))
  end

  it 'should change "php_coder" to "php-coder"' do
    expect(Redis.current.smembers('Sisyphus:chkrootkit:acls')
      .sort).to eq(%w(php-coder @everybody).sort)
  end

  it 'should change "psolntsev" to "p_solntsev"' do
    expect(Redis.current.smembers('Sisyphus:docs-cppreference:acls').sort)
      .to eq(%w(p_solntsev @qa).sort)
  end

  it 'should change "@vim_plugins" to "@vim-plugins"' do
    expect(Redis.current.smembers('Sisyphus:vim-plugin-CRefVIM:acls'))
      .to eq(['@vim-plugins'])
  end
end
