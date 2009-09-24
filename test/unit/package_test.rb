require 'test_helper'

class PackageTest < ActiveSupport::TestCase
  test "invalid with empty attributes" do
    package = Package.new
    assert !package.valid?
    assert package.errors.invalid?(:filename)
    assert package.errors.invalid?(:name)
    assert package.errors.invalid?(:version)
    assert package.errors.invalid?(:release)
    assert package.errors.invalid?(:arch)
    assert package.errors.invalid?(:packager_id)
    assert package.errors.invalid?(:group)
    assert package.errors.invalid?(:summary)
    assert package.errors.invalid?(:license)
    assert package.errors.invalid?(:description)
#    assert package.errors.invalid?(:vendor)
#    assert package.errors.invalid?(:distribution)
    assert package.errors.invalid?(:branch)
    assert package.errors.invalid?(:buildtime)
    assert package.errors.invalid?(:size)
  end
end
