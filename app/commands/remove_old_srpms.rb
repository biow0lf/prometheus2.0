# frozen_string_literal: true

class RemoveOldSrpms < Rectify::Command
  attr_reader :branches, :paths

  def initialize branches, paths
    @branches = [ branches ].flatten
    @paths = paths
  end

  def branch_ids
    branches.map(&:id)
  end

  def call
    Srpm.by_branch_id(branch_ids).each do |srpm|
      exists = paths.any? { |path| File.exist?("#{ path }#{ srpm.filename }") }

      if !exists
        srpm.destroy
        puts "SRPM #{srpm.filename} has been removed"
      end
    end

    broadcast(:ok)
  end
end
