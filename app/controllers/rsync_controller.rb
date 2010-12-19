class RsyncController < ApplicationController
  def new
    @branch = Branch.where(:name => 'Sisyphus', :vendor => 'ALT Linux').first
    @groups = @branch.groups.find(:all, :conditions => {:parent_id => nil}, :order => 'LOWER(name)')
  end
end