# frozen_string_literal: true

class RemoveOldSrpms < Rectify::Command
  attr_reader :branch_path

  def initialize branch_path
    @branch_path = branch_path
  end

  def log *args
    Rails.logger.info *args
  end

  def call
    NamedSrpm.by_branch_path(branch_path).each do |nsrpm|
      if !File.exist?("#{ branch_path.path }/#{ nsrpm.name }")
        srpm = nsrpm.srpm

        nsrpm.destroy
        if srpm.reload.named_srpms.blank?
          srpm.destroy
        end

        log "SRPM #{nsrpm.name} has been removed from #{branch_path.path} of #{branch_path.branch.name}"
      end
    end

    broadcast(:ok)
  end
end
