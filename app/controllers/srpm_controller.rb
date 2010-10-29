class SrpmController < ApplicationController
#  caches_page :main, :changelog, :rawspec, :patches, :sources, :download, :gear, :bugs, :allbugs, :repocop

  def main
    @branch = Branch.where(:vendor => 'ALT Linux', :name => params[:branch]).first
    @srpm = @branch.srpms.where(:name => params[:name]).includes(:packages, :group, :branch, :leader, :maintainer, :acls).first
    if @srpm != nil
      @allsrpms = Srpm.where(:name => params[:name]).joins(:branch).order("branches.order_id").all
    else
      render :status => 404, :action => "nosuchpackage"
    end
  end

  def changelog
    @branch = Branch.where(:vendor => 'ALT Linux', :name => params[:branch]).first
    @srpm = @branch.srpms.where(:name => params[:name]).includes(:group, :branch).first
    if @srpm != nil
      @allsrpms = Srpm.where(:name => params[:name]).joins(:branch).order("branches.order_id").all
    else
      render :status => 404, :action => "nosuchpackage"
    end
  end

  def rawspec
    @branch = Branch.where(:vendor => 'ALT Linux', :name => params[:branch]).first
    @srpm = @branch.srpms.where(:name => params[:name]).includes(:group, :branch).first
    if @srpm != nil
      @allsrpms = Srpm.where(:name => params[:name]).joins(:branch).order("branches.order_id").all
    else
      render :status => 404, :action => "nosuchpackage"
    end
  end

  def download
    @branch = Branch.where(:vendor => 'ALT Linux', :name => params[:branch]).first
    @srpm = @branch.srpms.where(:name => params[:name]).includes(:group, :branch, :packages).first
    if @srpm != nil
      @allsrpms = Srpm.where(:name => params[:name]).joins(:branch).order("branches.order_id").all
#      @i586 = Package.all :conditions => {
#                            :branch => @branch.name,
#                            :vendor => @branch.vendor,
#                            :sourcepackage => @srpm.filename,
#                            :arch => 'i586' },
#                          :order => 'name ASC'
#      @noarch = Package.all :conditions => {
#                              :branch => @branch.name,
#                              :vendor => @branch.vendor,
#                              :sourcepackage => @srpm.filename,
#                              :arch => 'noarch' },
#                            :order => 'name ASC'
#      @x86_64 = Package.all :conditions => {
#                              :branch => @branch.name,
#                              :vendor => @branch.vendor,
#                              :sourcepackage => @srpm.filename,
#                              :arch => 'x86_64' },
#                            :order => 'name ASC'
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

    @bugs = Bug.all :conditions => {
                      :component => params[:name],
                      :product => params[:branch],
                      :bug_status => ["NEW", "ASSIGNED", "VERIFIED", "REOPENED"]},
                    :order => "bug_id DESC"
    @allbugs = Bug.all :conditions => {
                         :component => params[:name],
                         :product => params[:branch] },
                       :order => "bug_id DESC"
    if @srpm == nil
      render :status => 404, :action => "nosuchpackage"
    end
  end

  def allbugs
    @branch = Branch.where(:vendor => 'ALT Linux', :name => params[:branch]).first
    @srpm = @branch.srpms.where(:name => params[:name]).includes(:group, :branch).first

    @bugs = Bug.all :conditions => {
                      :component => params[:name],
                      :product => params[:branch],
                      :bug_status => ["NEW", "ASSIGNED", "VERIFIED", "REOPENED"]},
                    :order => "bug_id DESC"

    @allbugs = Bug.all :conditions => {
                         :component => params[:name],
                         :product => params[:branch] },
                       :order => "bug_id DESC"
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
                                :srcrel => @srpm.release).all
    else
      render :status => 404, :action => "nosuchpackage"
    end
  end

  def nosuchpackage
  end
end