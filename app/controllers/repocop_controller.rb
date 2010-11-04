class RepocopController < ApplicationController
  layout nil

  def missing_url
    @branch = Branch.where(:name => 'Sisyphus', :vendor => 'ALT Linux').first
    @srpms = Srpm.where(:branch_id => @branch.id, :url => nil).order("name ASC").all
  end

  def vendor_tag
    @branch = Branch.where(:name => 'Sisyphus', :vendor => 'ALT Linux').first
    # "^" mean "!=" in sql
    @srpms = Srpm.where(:branch_id => @branch.id).where(:vendor ^ 'ALT Linux Team').order("name ASC").all
  end

  def distribution_tag
    @branch = Branch.where(:name => 'Sisyphus', :vendor => 'ALT Linux').first
    # "^" mean "!=" in sql
    @srpms = Srpm.where(:branch_id => @branch.id).where(:distribution ^ 'ALT Linux').order("name ASC").all
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
                                      ).order('name ASC').all
  end
  
  def srpm_long_summary
    @branch = Branch.where(:name => 'Sisyphus', :vendor => 'ALT Linux').first
    @srpms = @branch.srpms.where('length(summary) > 79').order('name ASC').all
  end

  def packages_long_summary
    @branch = Branch.where(:name => 'Sisyphus', :vendor => 'ALT Linux').first
    @packages = @branch.packages.where('length(summary) > 79').order('name ASC').all
  end
end