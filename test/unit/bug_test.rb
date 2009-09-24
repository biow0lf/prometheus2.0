require 'test_helper'

class BugTest < ActiveSupport::TestCase
  test "invalid with empty attributes" do
    bug = Bug.new
    assert !bug.valid?
    assert bug.errors.invalid?(:bug_id)
    assert bug.errors.invalid?(:bug_status)
    assert bug.errors.invalid?(:bug_severity)
    assert bug.errors.invalid?(:product)
    assert bug.errors.invalid?(:component)
    assert bug.errors.invalid?(:assigned_to)
    assert bug.errors.invalid?(:reporter)
    assert bug.errors.invalid?(:short_desc)
  end
end

