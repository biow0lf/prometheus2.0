Fabricator(:srpm) do
  name 'openbox'
  version '3.4.11.1'
  release 'alt1.1.1'
  group_id 0
  branch { Fabricate(:branch) }
  md5 'f87ff0eaa4e16b202539738483cd54d1'
end
