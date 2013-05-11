hash = Hash.new

hash[:branch]  = @branch.name
hash[:name]    = @srpm.name
hash[:version] = @srpm.version
hash[:release] = @srpm.release
hash[:epoch]   = @srpm.epoch

hash[:repocops] = @repocops.map do |repocop|
  {
    branch_id: repocop.branch_id,
    name: repocop.name,
    version: repocop.version,
    release: repocop.release,
    arch: repocop.arch,
    srcname: repocop.srcname,
    srcversion: repocop.srcversion,
    srcrel: repocop.srcrel,
    testname: repocop.testname,
    status: repocop.status,
    message: repocop.message
  }
end

hash.to_json
