hash = Hash.new

hash[:branch] = @branch.name

hash[:repocops] = @repocops.map do |repocop|
  {
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

