require 'test_helper'

class AclTest < ActiveSupport::TestCase
  test "invalid with empty attributes" do
    acl = Acl.new
    assert !acl.valid?
    assert acl.errors.invalid?(:package)
    assert acl.errors.invalid?(:login)
    assert acl.errors.invalid?(:branch)
  end
end
