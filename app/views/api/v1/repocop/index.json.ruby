hash = Hash.new

hash[:branch] = @branch.name

hash[:testnames] = @repocop_testnames.map do |repocop|
  {
    testname: repocop.testname
  }
end

hash.to_json

