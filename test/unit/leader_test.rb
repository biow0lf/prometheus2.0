require 'test_helper'

class LeaderTest < ActiveSupport::TestCase
  test "invalid with empty attributes" do
    leader = Leader.new
    assert !leader.valid?
    assert leader.errors.invalid?(:package)
    assert leader.errors.invalid?(:login)
    assert leader.errors.invalid?(:branch)
  end
end
