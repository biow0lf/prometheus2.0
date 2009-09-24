require 'test_helper'

class PackagerTest < ActiveSupport::TestCase
  test "invalid with empty attributes" do
    packager = Packager.new
    assert !packager.valid?
    assert packager.errors.invalid?(:name)
    assert packager.errors.invalid?(:email)
    assert packager.errors.invalid?(:login)
  end
end
