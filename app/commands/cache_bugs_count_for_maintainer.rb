# frozen_string_literal: true

class CacheBugsCountForMaintainer < Rectify::Command
  attr_reader :branch

  def initialize(branch)
    @branch = branch
  end

  def call
    # return broadcast(:failed) unless Redis.current.connected?
    #
    # branch.counter.value = branch.srpms.count
    #
    # broadcast(:ok)
  end
end
