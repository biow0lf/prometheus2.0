require 'test_helper'

class RepocopTest < ActiveSupport::TestCase
  test "invalid with empty attributes" do
    repocop = Repocop.new
    assert !repocop.valid?
    assert repocop.errors.invalid?(:name)
    assert repocop.errors.invalid?(:version)
    assert repocop.errors.invalid?(:release)
    assert repocop.errors.invalid?(:arch)
    assert repocop.errors.invalid?(:srcname)
    assert repocop.errors.invalid?(:srcversion)
    assert repocop.errors.invalid?(:srcrel)
    assert repocop.errors.invalid?(:testname)
  end
end
