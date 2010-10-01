class SrpmController < ApplicationController
#  caches_page :main, :changelog, :rawspec, :patches, :sources, :download, :gear, :bugs, :allbugs, :repocop

  def main
    @branch = Branch.first :conditions => { :vendor => 'ALT Linux', :name => params[:branch] }
    @srpm = Srpm.first :conditions => {
                         :name => params[:name],
                         :branch_id => @branch.id },
                       :include => [:packages, :group]
    if @srpm != nil
#      @allsrpms = Srpm.find :all,
#                            :conditions => { :name => params[:name] }\

#      @allsrpms = Srpm.find_by_sql ["SELECT srpms.name, srpms.version,
#                                            srpms.release, branches.name,
#                                            branches.order_id
#                                     FROM srpms, branches
#                                     WHERE srpms.branch_id = branches.id
#                                     AND srpms.name = ?
#                                     ORDER BY branches.order_id ASC", params[:name]]

      if params[:branch] == 'Sisyphus' or
         params[:branch] == '5.1' or
         params[:branch] == '5.0' or
         params[:branch] == '4.1' or
         params[:branch] == '4.0'
#        @packages = Package.all :conditions => {
#                                  :branch => @branch.name,
#                                  :vendor => @branch.vendor,
#                                  :sourcepackage => @srpm.filename,
#                                  :arch => ["noarch", "i586"] },
#                                :order => 'name ASC'
        @leader = Leader.first :conditions => {
                                 :branch_id => @branch.id,
                                 :package => params[:name] }
        @packager = Packager.first :conditions => { :login => @leader.login }
      elsif params[:branch] == 'SisyphusARM'
#        @packages = Package.all :conditions => {
#                                  :branch => @branch.name,
#                                  :vendor => @branch.vendor,
#                                  :sourcepackage => @srpm.filename,
#                                  :arch => ["noarch", "arm"] },
#                                :order => 'name ASC'        
      elsif params[:branch] == 'Platform5'
#        @packages = Package.all :conditions => {
#                                  :branch => @branch.name,
#                                  :vendor => @branch.vendor,
#                                  :sourcepackage => @srpm.filename,
#                                  :arch => ["noarch", "i586"] },
#                                :order => 'name ASC'
      end
    else
      render :status => 404, :action => "nosuchpackage"
    end
  end

  def changelog
    @branch = Branch.first :conditions => { :vendor => 'ALT Linux', :name => params[:branch] }
    @srpm = Srpm.first :conditions => {
                         :name => params[:name],
                         :branch_id => @branch.id },
                       :include => [:group, :branch]
    if @srpm == nil
      render :status => 404, :action => "nosuchpackage"
    end
  end

  def rawspec
    @branch = Branch.first :conditions => { :vendor => 'ALT Linux', :name => params[:branch] }
    @srpm = Srpm.first :conditions => {
                         :name => params[:name],
                         :branch => @branch.name,
                         :vendor => @branch.vendor }
    if @srpm == nil
      render :status => 404, :action => "nosuchpackage"
    end
  end

  def download
    @branch = Branch.first :conditions => { :vendor => 'ALT Linux', :name => params[:branch] }
    @srpm = Srpm.first :conditions => {
                         :name => params[:name],
                         :branch => @branch.name,
                         :vendor => @branch.vendor }
    if @srpm != nil
      @allsrpms = Srpm.find_by_sql ["SELECT srpms.name, srpms.version,
                                            srpms.release, srpms.branch,
                                            order_id
                                     FROM srpms, branches
                                     WHERE srpms.branch = branches.name
                                     AND srpms.name = ?
                                     ORDER BY branches.order_id ASC", params[:name]]
      @i586 = Package.all :conditions => {
                            :branch => @branch.name,
                            :vendor => @branch.vendor,
                            :sourcepackage => @srpm.filename,
                            :arch => 'i586' },
                          :order => 'name ASC'
      @noarch = Package.all :conditions => {
                              :branch => @branch.name,
                              :vendor => @branch.vendor,
                              :sourcepackage => @srpm.filename,
                              :arch => 'noarch' },
                            :order => 'name ASC'
      @x86_64 = Package.all :conditions => {
                              :branch => @branch.name,
                              :vendor => @branch.vendor,
                              :sourcepackage => @srpm.filename,
                              :arch => 'x86_64' },
                            :order => 'name ASC'
    else
      render :status => 404, :action => "nosuchpackage"
    end
  end

  def gear
    @branch = Branch.first :conditions => { :vendor => 'ALT Linux', :name => params[:branch] }
    @srpm = Srpm.first :conditions => {
                         :name => params[:name],
                         :branch => @branch.name,
                         :vendor => @branch.vendor }
    if @srpm != nil
      @gitrepos = Gitrepo.all :conditions => { :repo => @srpm.name },
                               :order => 'lastchange DESC'
    else
      render :status => 404, :action => "nosuchpackage"
    end
  end

  def bugs
    @branch = Branch.first :conditions => { :vendor => 'ALT Linux', :name => params[:branch] }
    @bugs = Bug.all :conditions => {
                      :component => params[:name],
                      :product => params[:branch],
                      :bug_status => ["NEW", "ASSIGNED", "VERIFIED", "REOPENED"]},
                    :order => "bug_id DESC"

    @allbugs = Bug.all :conditions => {
                         :component => params[:name],
                         :product => params[:branch] },
                       :order => "bug_id DESC"
  end

  def allbugs
    @branch = Branch.first :conditions => { :vendor => 'ALT Linux', :name => params[:branch] }
    @bugs = Bug.all :conditions => {
                      :component => params[:name],
                      :product => params[:branch],
                      :bug_status => ["NEW", "ASSIGNED", "VERIFIED", "REOPENED"]},
                    :order => "bug_id DESC"

    @allbugs = Bug.all :conditions => {
                         :component => params[:name],
                         :product => params[:branch] },
                       :order => "bug_id DESC"
  end

  def repocop
    @branch = Branch.first :conditions => { :vendor => 'ALT Linux', :name => params[:branch] }
    @srpm = Srpm.first :conditions => {
                         :name => params[:name],
                         :branch => @branch.name,
                         :vendor => @branch.vendor }

    if @srpm != nil
      @repocops = Repocop.all :conditions => {
                                :srcname => @srpm.name,
                                :srcversion => @srpm.version,
                                :srcrel => @srpm.release }

#    if @srpm == nil
    else
      render :status => 404, :action => "nosuchpackage"
    end
  end

  def nosuchpackage
  end
end