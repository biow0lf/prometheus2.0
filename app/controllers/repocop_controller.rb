class RepocopController < ApplicationController
  layout nil

  def no_url_tag
    @branch = Branch.where(:name => 'Sisyphus', :vendor => 'ALT Linux').first
    @srpms = Srpm.where(:branch_id => @branch.id, :url => nil).order("name ASC")
  end

  def invalid_url
    @branch = Branch.where(:name => 'Sisyphus', :vendor => 'ALT Linux').first
    #                                    url != '' AND url NOT LIKE 'http://%' AND ....
    @srpms = Srpm.where(:branch_id => @branch.id).where(
                                        (:url ^ '') &
                                        (:url.not_matches % 'http://%') &
                                        (:url.not_matches % 'https://%') &
                                        (:url.not_matches % 'ftp://%') &
                                        (:url.not_matches % 'rsync://%')
                                      ).order('name ASC')
  end

  def invalid_vendor
    @branch = Branch.where(:name => 'Sisyphus', :vendor => 'ALT Linux').first
    # "^" mean "!=" in sql
    @srpms = Srpm.where(:branch_id => @branch.id).where(:vendor ^ 'ALT Linux Team').order("name ASC")
  end

  def invalid_distribution
    @branch = Branch.where(:name => 'Sisyphus', :vendor => 'ALT Linux').first
    # "^" mean "!=" in sql
    @srpms = Srpm.where(:branch_id => @branch.id).where(:distribution ^ 'ALT Linux').order("name ASC")
  end

  def srpms_summary_too_long
    @branch = Branch.where(:name => 'Sisyphus', :vendor => 'ALT Linux').first
    @srpms = @branch.srpms.where('length(summary) > 79').order('name ASC')
  end

  def packages_summary_too_long
    @branch = Branch.where(:name => 'Sisyphus', :vendor => 'ALT Linux').first
    @packages = @branch.packages.where('length(summary) > 79').order('name ASC')
  end

  def srpms_summary_ended_with_dot
    @branch = Branch.where(:name => 'Sisyphus', :vendor => 'ALT Linux').first
    @srpms = @branch.srpms.where(:summary.matches => '%.').order('name ASC')
  end

  def packages_summary_ended_with_dot
    @branch = Branch.where(:name => 'Sisyphus', :vendor => 'ALT Linux').first
    @packages = @branch.packages.where(:summary.matches => '%.').order('name ASC')
  end

  def srpms_filename_too_long_for_joliet
    @branch = Branch.where(:name => 'Sisyphus', :vendor => 'ALT Linux').first
    @srpms = @branch.srpms.where('length(filename) > 64').order('name ASC')
  end

  def packages_filename_too_long_for_joliet
    @branch = Branch.where(:name => 'Sisyphus', :vendor => 'ALT Linux').first
    @packages = @branch.packages.where('length(filename) > 64').order('name ASC')
  end

  # TODO:
  def manpage_not_compressed
  end

  def infopage_not_compressed
  end

  def buildreq_ccache
  end
end