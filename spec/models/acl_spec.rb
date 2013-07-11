require 'spec_helper'

describe Acl do
  before(:each) do
    FactoryGirl.create(:branch)

    page = `cat spec/data/list.packages.sisyphus`
    FakeWeb.register_uri(:get,
                         'http://git.altlinux.org/acl/list.packages.sisyphus',
                         response: page)

    Acl.update_redis_cache('ALT Linux',
                           'Sisyphus',
                           'http://git.altlinux.org/acl/list.packages.sisyphus')
  end

  it "should import and update acls" do
    $redis.smembers('Sisyphus:rpm:acls').sort.should eq(['ldv', 'at'].sort)
    $redis.smembers('Sisyphus:maintainers:ldv').should eq(['rpm'])
    $redis.smembers('Sisyphus:maintainers:at').should eq(['rpm'])
  end

  it "should change 'php_coder' to 'php-coder'" do
    $redis.smembers('Sisyphus:chkrootkit:acls').sort.should eq(['php-coder', '@everybody'].sort)
  end

  it "should change 'psolntsev' to 'p_solntsev'" do
    $redis.smembers('Sisyphus:docs-cppreference:acls').sort.should eq(['p_solntsev', '@qa'].sort)
  end

  it "should change '@vim_plugins' to '@vim-plugins'" do
    $redis.smembers('Sisyphus:vim-plugin-CRefVIM:acls').should eq(['@vim-plugins'])
  end
end
