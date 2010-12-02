class SrpmController < ApplicationController
#  caches_page :main, :changelog, :rawspec, :patches, :sources, :download, :gear, :bugs, :allbugs, :repocop

  def main
    @branch = Branch.where(:vendor => 'ALT Linux', :name => params[:branch]).first
    @srpm = @branch.srpms.where(:name => params[:name]).includes(:packages, :group, :branch, :leader, :maintainer, :acls).first
    if @srpm != nil
      @allsrpms = Srpm.where(:name => params[:name]).joins(:branch).order("branches.order_id")
    else
      render :status => 404, :action => "nosuchpackage"
    end
  end

  def changelog
    @branch = Branch.where(:vendor => 'ALT Linux', :name => params[:branch]).first
    @srpm = @branch.srpms.where(:name => params[:name]).includes(:group, :branch).first
    if @srpm != nil
      @changelogs = @srpm.changelogs.order('created_at ASC')
      @allsrpms = Srpm.where(:name => params[:name]).joins(:branch).order("branches.order_id")
    else
      render :status => 404, :action => "nosuchpackage"
    end
  end

  def rawspec
    @branch = Branch.where(:vendor => 'ALT Linux', :name => params[:branch]).first
    @srpm = @branch.srpms.where(:name => params[:name]).includes(:group, :branch).first
    if @srpm != nil
      @allsrpms = Srpm.where(:name => params[:name]).joins(:branch).order("branches.order_id")
    else
      render :status => 404, :action => "nosuchpackage"
    end
  end

  def download
    @branch = Branch.where(:vendor => 'ALT Linux', :name => params[:branch]).first
    @srpm = @branch.srpms.where(:name => params[:name]).includes(:group, :branch, :packages).first
    if @srpm != nil
      @allsrpms = Srpm.where(:name => params[:name]).joins(:branch).order("branches.order_id")
      @i586 = @srpm.packages.where(:arch => 'i586').order("name ASC")
      @noarch = @srpm.packages.where(:arch => 'noarch').order("name ASC")
      @x86_64 = @srpm.packages.where(:arch => 'x86_64').order("name ASC")
      @arm = @srpm.packages.where(:arch => 'arm').order("name ASC")
    else
      render :status => 404, :action => "nosuchpackage"
    end
  end

  def gear
    @branch = Branch.where(:vendor => 'ALT Linux', :name => params[:branch]).first
    @srpm = @branch.srpms.where(:name => params[:name]).includes(:group, :branch).first
    if @srpm != nil
#      @gitrepos = Gitrepo.all :conditions => { :repo => @srpm.name },
#                               :order => 'lastchange DESC'
      @gitrepos = Gitrepo.all :conditions => {
                                :srpm_id => @srpm.id },
                              :order => 'lastchange DESC'
    else
      render :status => 404, :action => "nosuchpackage"
    end
  end

  def bugs
    @branch = Branch.where(:vendor => 'ALT Linux', :name => params[:branch]).first
    @srpm = @branch.srpms.where(:name => params[:name]).includes(:group, :branch).first

    @bugs = Bug.where(:component => params[:name],
                      :product => params[:branch],
                      :bug_status => ["NEW", "ASSIGNED", "VERIFIED", "REOPENED"]
                      ).order("bug_id DESC")

    @allbugs = Bug.where(:component => params[:name],
                         :product => params[:branch]
                         ).order("bug_id DESC")
    if @srpm == nil
      render :status => 404, :action => "nosuchpackage"
    end
  end

  def allbugs
    @branch = Branch.where(:vendor => 'ALT Linux', :name => params[:branch]).first
    @srpm = @branch.srpms.where(:name => params[:name]).includes(:group, :branch).first

    @bugs = Bug.where(:component => params[:name],
                      :product => params[:branch],
                      :bug_status => ["NEW", "ASSIGNED", "VERIFIED", "REOPENED"]
                      ).order("bug_id DESC")

    @allbugs = Bug.where(:component => params[:name],
                         :product => params[:branch]
                         ).order("bug_id DESC")
    if @srpm == nil
      render :status => 404, :action => "nosuchpackage"
    end
  end

  def repocop
    @branch = Branch.where(:vendor => 'ALT Linux', :name => params[:branch]).first
    @srpm = @branch.srpms.where(:name => params[:name]).includes(:group, :branch).first
    if @srpm != nil
      @repocops = Repocop.where(:srcname => @srpm.name,
                                :srcversion => @srpm.version,
                                :srcrel => @srpm.release)
    else
      render :status => 404, :action => "nosuchpackage"
    end
  end
end