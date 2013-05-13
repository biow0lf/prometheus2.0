class RepocopController < ApplicationController
  layout false

  def no_url_tag
    @branch = Branch.where(name: 'Sisyphus', vendor: 'ALT Linux').first
    @srpms = @branch.srpms.where(url: nil).order("name ASC")
  end

  def invalid_url
    @branch = Branch.where(name: 'Sisyphus', vendor: 'ALT Linux').first
    @srpms = @branch.srpms.where("url != ''").
                           where("url NOT LIKE 'http://%'").
                           where("url NOT LIKE 'https://%'").
                           where("url NOT LIKE 'ftp://%'").
                           where("url NOT LIKE 'rsync://%'").
                           order('name ASC')
  end

  def invalid_vendor
    @branch = Branch.where(name: 'Sisyphus', vendor: 'ALT Linux').first
    @srpms = @branch.srpms.where("vendor != 'ALT Linux Team'").order('name ASC')
  end

  def invalid_distribution
    @branch = Branch.where(name: 'Sisyphus', vendor: 'ALT Linux').first
    @srpms = @branch.srpms.where("distribution != 'ALT Linux'").order('name ASC')
  end

  def srpms_summary_too_long
    @branch = Branch.where(name: 'Sisyphus', vendor: 'ALT Linux').first
    @srpms = @branch.srpms.where('length(summary) > 79').order('name ASC')
  end

  def packages_summary_too_long
    @branch = Branch.where(name: 'Sisyphus', vendor: 'ALT Linux').first
    @packages = @branch.packages.where('length(summary) > 79').order('name ASC')
  end

  def srpms_summary_ended_with_dot
    @branch = Branch.where(name: 'Sisyphus', vendor: 'ALT Linux').first
    @srpms = @branch.srpms.where("summary LIKE '%.'").order('name ASC')
  end

  def packages_summary_ended_with_dot
    @branch = Branch.where(name: 'Sisyphus', vendor: 'ALT Linux').first
    @packages = @branch.packages.where("summary LIKE '%.'").order('name ASC')
  end

  def srpms_filename_too_long_for_joliet
    @branch = Branch.where(name: 'Sisyphus', vendor: 'ALT Linux').first
    @srpms = @branch.srpms.where('length(filename) > 64').order('name ASC')
  end

  def packages_filename_too_long_for_joliet
    @branch = Branch.where(name: 'Sisyphus', vendor: 'ALT Linux').first
    @packages = @branch.packages.where('length(filename) > 64').order('name ASC')
  end

  # TODO:
  def manpage_not_compressed
  end

  def infopage_not_compressed
  end

  def buildreq_ccache
  end

  def srpms_install_s
    @branch = Branch.where(name: 'Sisyphus', vendor: 'ALT Linux').first
#    @specfiles = @branch.specfile.where("spec LIKE ?", '%install -s%').includes(:srpm)
    @specfiles = Specfile.where(branch_id: @branch.id).where("spec LIKE ?", '%install -s%').includes(:srpm)
  end
end
