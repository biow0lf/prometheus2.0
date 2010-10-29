class SrpmController < ApplicationController
#  caches_page :main, :changelog, :rawspec, :patches, :sources, :download, :gear, :bugs, :allbugs, :repocop

  def main
    @branch = Branch.where(:vendor => 'ALT Linux', :name => params[:branch]).first
    @srpm = @branch.srpms.find(:first,
                               :conditions => { :name => params[:name] },
                               :include => [:packages, :group, :branch, :leader, :maintainer, :acls])
    if @srpm != nil
      @allsrpms = Srpm.find :all, :conditions => {
                                    :name => params[:name] },
                                  :joins => :branch,
                                  :order => "branches.order_id"
    else
      render :status => 404, :action => "nosuchpackage"
    end
  end

  def changelog
    @branch = Branch.where(:vendor => 'ALT Linux', :name => params[:branch]).first
    @srpm = Srpm.first :conditions => {
                         :name => params[:name],
                         :branch_id => @branch.id },
                       :include => [:group, :branch]
    if @srpm != nil
      @allsrpms = Srpm.find :all, :conditions => {
                                    :name => params[:name] },
                                  :joins => :branch,
                                  :order => "branches.order_id"
    else
      render :status => 404, :action => "nosuchpackage"
    end
  end

  def rawspec
    @branch = Branch.where(:vendor => 'ALT Linux', :name => params[:branch]).first
    @srpm = Srpm.first :conditions => {
                         :name => params[:name],
                         :branch_id => @branch.id },
                       :include => [:branch, :group]
    if @srpm != nil
      @allsrpms = Srpm.find :all, :conditions => {
                                    :name => params[:name] },
                                  :joins => :branch,
                                  :order => "branches.order_id"
    else
      render :status => 404, :action => "nosuchpackage"
    end
  end

  def download
    @branch = Branch.where(:vendor => 'ALT Linux', :name => params[:branch]).first
    @srpm = Srpm.first :conditions => {
                         :name => params[:name],
                         :branch_id => @branch.id },
                       :include => [:group, :branch, :packages]
    if @srpm != nil
      @allsrpms = Srpm.find :all, :conditions => {
                                    :name => params[:name] },
                                  :joins => :branch,
                                  :order => "branches.order_id"
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
    @srpm = Srpm.first :conditions => {
                         :name => params[:name],
                         :branch_id => @branch.id }
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
    @srpm = Srpm.first :conditions => {
                         :name => params[:name],
                         :branch_id => @branch.id }
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
    @srpm = Srpm.first :conditions => {
                         :name => params[:name],
                         :branch_id => @branch.id }
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
    @srpm = @branch.srpms.find(:first,
                               :conditions => {:name => params[:name]})
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