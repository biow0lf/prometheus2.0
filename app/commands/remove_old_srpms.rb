# frozen_string_literal: true

class RemoveOldSrpms < Rectify::Command
  attr_reader :branch, :path

  def initialize branch, path
    @branch = branch
    @path = path
  end

  def log *args
    Rails.logger.info *args
  end

  def call
    NamedSrpm.by_branch_id(branch.id).each do |nsrpm|
      if !File.exist?("#{ path }#{ nsrpm.name }")
        srpm = nsrpm.srpm

        nsrpm.destroy
        if srpm.reload.named_srpms.blank?
          srpm.destroy
        end

        log "SRPM #{nsrpm.name} has been removed from #{branch.name}"
      end
    end

    broadcast(:ok)
  end
end
