require 'test_helper'

class GroupTest < ActiveSupport::TestCase
  test "invalid with empty attributes" do
    group = Group.new
    assert !group.valid?
    assert group.errors.invalid?(:name)
    assert group.errors.invalid?(:branch)
  end
end
