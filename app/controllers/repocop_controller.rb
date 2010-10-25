class RepocopController < ApplicationController
  layout nil

  def missing_url
    @branch = Branch.where(:name => 'Sisyphus', :vendor => 'ALT Linux').first
    @srpms = Srpm.where(:branch_id => @branch.id, :url => nil).all
  end
end