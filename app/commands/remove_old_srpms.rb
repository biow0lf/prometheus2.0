# frozen_string_literal: true

class RemoveOldSrpms < Rectify::Command
  attr_reader :branch_path

  def initialize branch_path
    @branch_path = branch_path
  end

  def log *args
    Rails.logger.info *args
  end

  def list
    find = "find #{branch_path.path} -name '#{branch_path.glob}' | sed 's|#{branch_path.path}/*||' | sort"

    current_list = `#{find}`.split("\n")
    stored_list = branch_path.named_srpms.select(:filename).pluck(:filename)

    stored_list - current_list
  end

  def count
    list.count
  end

  def call
    list = self.list

    list_to_remove = branch_path.named_srpms.where(filename: list)
    builder_ids = Srpm.where(id: list_to_remove.select(:srpm_id)).select(:builder_id).distinct.pluck(:builder_id)

    list_to_remove.update_all(obsoleted_at: Time.zone.now)
    list.each { |f| Rails.logger.info "IMPORT: removed file #{f} for #{branch_path.name}" }

    BranchPath.reset_counters(branch_path.id, :srpms_count)
    branch_path.branch.update!(srpms_count: branch_path.branch.srpm_filenames.count)

    branch_path.builders.where(id: builder_ids).find_each do |maintainer|
      maintainer.branching_maintainers.where(branch_id: branch_path.branch).each do |branching_maintainer|
        srpms_count = maintainer.srpm_names.joins(:branch_path).where(branch_paths: { branch_id: branch_path.branch }).count
        if srpms_count != branching_maintainer.srpms_count
          Rails.logger.info "IMPORT: difference for counter for #{branch_path.name} in #{srpms_count - branching_maintainer.srpms_count}"

          branching_maintainer.update!(srpms_count: srpms_count)
        end
      end
    end

    broadcast(:ok)
  end
end
