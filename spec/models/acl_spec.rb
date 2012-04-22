# encoding: utf-8

require 'spec_helper'

describe Acl do
  it "should import and update acls" do
    Branch.create(name: 'Sisyphus', vendor: 'ALT Linux')

    page = `cat spec/data/list.packages.sisyphus`

    FakeWeb.register_uri(:get,
                         'http://git.altlinux.org/acl/list.packages.sisyphus',
                         response: page)

    Acl.update_redis_cache('ALT Linux',
                           'Sisyphus',
                           'http://git.altlinux.org/acl/list.packages.sisyphus')

    $redis.smembers('Sisyphus:rpm:acls').sort.should == ['ldv', 'at'].sort
    $redis.smembers('Sisyphus:maintainers:ldv').should == ['rpm']
    $redis.smembers('Sisyphus:maintainers:at').should == ['rpm']

    $redis.smembers('Sisyphus:chkrootkit:acls').sort.should == ['php-coder', '@everybody'].sort

    $redis.smembers('Sisyphus:docs-cppreference:acls').sort.should == ['p_solntsev', '@qa'].sort

    $redis.smembers('Sisyphus:vim-plugin-CRefVIM:acls').should == ['@vim-plugins']
  end
end
