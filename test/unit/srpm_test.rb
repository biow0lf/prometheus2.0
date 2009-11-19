require 'test_helper'

class SrpmTest < ActiveSupport::TestCase
  test "invalid with empty attributes" do
    srpm = Srpm.new
    assert !srpm.valid?
    assert srpm.errors.invalid?(:filename)
    assert srpm.errors.invalid?(:name)
    assert srpm.errors.invalid?(:version)
    assert srpm.errors.invalid?(:release)
#    assert srpm.errors.invalid?(:packager_id)
    assert srpm.errors.invalid?(:group_id)
    assert srpm.errors.invalid?(:summary)
    assert srpm.errors.invalid?(:license)
#    assert srpm.errors.invalid?(:description)
#    assert srpm.errors.invalid?(:vendor)
#    assert srpm.errors.invalid?(:distribution)
    assert srpm.errors.invalid?(:branch_id)
    assert srpm.errors.invalid?(:buildtime)
    assert srpm.errors.invalid?(:size)
  end
end
