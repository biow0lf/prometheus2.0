require 'test_helper'

class TeamTest < ActiveSupport::TestCase
  test "invalid with empty attributes" do
    team = Team.new
    assert !team.valid?
    assert team.errors.invalid?(:name)
    assert team.errors.invalid?(:login)
    assert team.errors.invalid?(:branch_id)
  end
end
