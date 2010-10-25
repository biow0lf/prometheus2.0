class CliController < ApplicationController
  layout nil

  def srpm_info
    @branch = Branch.where(:name => params[:branch], :vendor => params[:vendor]).first
    @srpm = Srpm.where(:name => params[:name], :branch_id => @branch.id).first
  end

  def srpm_changelog
  end
  
  def srpm_spec
  end

  def srpm_get
  end
  
  def srpm_gear
  end
  
  def srpm_bugs
  end
  
  def srpm_allbugs
  end
  
  def srpm_repocop
  end
end