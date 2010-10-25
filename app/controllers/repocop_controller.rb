class RepocopController < ApplicationController
  layout nil

  def missing_url
    @branch = Branch.where(:name => 'Sisyphus', :vendor => 'ALT Linux').first
    @srpms = Srpm.where(:branch_id => @branch.id, :url => nil).all
  end
  
  def vendor_tag
    @branch = Branch.where(:name => 'Sisyphus', :vendor => 'ALT Linux').first
    @srpms = Srpm.where(:branch_id => @branch.id).where(["(vendor <> 'ALT Linux Team' OR vendor IS NULL)"]).all    
  end
  
  def distribution_tag
    @branch = Branch.where(:name => 'Sisyphus', :vendor => 'ALT Linux').first
    @srpms = Srpm.where(:branch_id => @branch.id).where(["(distribution <> 'ALT Linux' OR distribution IS NULL)"]).all
  end
end