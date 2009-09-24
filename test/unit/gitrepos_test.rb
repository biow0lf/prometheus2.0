require 'test_helper'

class GitreposTest < ActiveSupport::TestCase
  test "invalid with empty attributes" do
    gitrepo = Gitrepos.new
    assert !gitrepo.valid?
    assert gitrepo.errors.invalid?(:package)
    assert gitrepo.errors.invalid?(:login)
    assert gitrepo.errors.invalid?(:lastchange)
  end
end
