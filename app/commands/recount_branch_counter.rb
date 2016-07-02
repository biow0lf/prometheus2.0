class RecountBranchCounter < Rectify::Command
  attr_reader :branch

  def initialize(branch)
    @branch = branch
  end

  def call
    branch.counter.value = branch.srpms.count

    broadcast(:ok)
  # TODO:
  # rescue Redis::CannotConnectError
  #   broadcast(:failed)
  end
end
