require 'test_helper'

class FtbfsTest < ActiveSupport::TestCase
  test "invalid with empty attributes" do
    ftbfs = Ftbfs.new
    assert !ftbfs.valid?
    assert ftbfs.errors.invalid?(:name)
#    assert ftbfs.errors.invalid?(:version)
#    assert ftbfs.errors.invalid?(:release)
    assert ftbfs.errors.invalid?(:weeks)
    assert ftbfs.errors.invalid?(:login)
  end
end
