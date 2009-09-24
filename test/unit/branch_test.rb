require 'test_helper'

class BranchTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "invalid with empty attributes"  do
    branch = Branch.new
    assert !branch.valid?
    assert branch.errors.invalid?(:fullname)
    assert branch.errors.invalid?(:urlname)
  end
end
