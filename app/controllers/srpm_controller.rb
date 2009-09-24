class SrpmController < ApplicationController
  layout "default"

  def main
    @package_counter = Srpm.count :conditions => { :branch => 'Sisyphus' }

    @srpm = Srpm.find :first,
                      :conditions => {
                        :name => params[:name],
                        :branch => params[:branch] }

    if @srpm != nil
      if params[:branch] == 'Sisyphus'
        @acl = Acl.find :all,
                        :conditions => {
                          :package => params[:name],
                          :branch => params[:branch] }
        @packages = Package.find :all,
                                 :conditions => {
                                   :branch => params[:branch],
                                   :sourcepackage => @srpm.filename,
                                   :arch => ["noarch", "i586"] },
                                 :order => 'name ASC'
        @leader = Leader.find :first,
                              :conditions => {
                                :branch => params[:branch],
                                :package => params[:name] }
        @packager = Packager.find :first,
                                  :conditions => { :login => @leader.login }
      end
    end
    @allsrpms = Srpm.find :all,
                          :conditions => { :name => params[:name] },
                          :order => 'branch ASC'
  end

  def changelog
    @package_counter = Srpm.count :conditions => { :branch => 'Sisyphus' }
    @srpm = Srpm.find :first,
                      :conditions => {
                        :name => params[:name],
                        :branch => params[:branch] }
    #@changelogs = Changelog.find(:all, :conditions => { :srpm_id => @srpm.id})
  end

  def rawspec
    @package_counter = Srpm.count :conditions => { :branch => 'Sisyphus' }
    @srpm = Srpm.find :first,
                      :conditions => {
                        :name => params[:name],
                        :branch => params[:branch] }
  end

  def patches
    @package_counter = Srpm.count :conditions => { :branch => 'Sisyphus' }
    @srpm = Srpm.find :first,
                      :conditions => {
                        :name => params[:name],
                        :branch => params[:branch] }
  end

  def sources
    @package_counter = Srpm.count :conditions => { :branch => 'Sisyphus' }
    @srpm = Srpm.find :first,
                      :conditions => {
                        :name => params[:name],
                        :branch => params[:branch] }
  end

  def download
    @package_counter = Srpm.count :conditions => { :branch => 'Sisyphus' }
    @srpm = Srpm.find :first,
                      :conditions => {
                        :name => params[:name],
                        :branch => params[:branch] }
    @branch = Branch.find :first,
                          :conditions => { :urlname => params[:branch] }
    if @srpm != nil
      @i586 = Package.find :all,
                           :conditions => {
                             :branch => params[:branch],
                             :sourcepackage => @srpm.filename,
                             :arch => 'i586' },
                           :order => 'name ASC'
      @noarch = Package.find :all,
                             :conditions => {
                               :branch => params[:branch],
                               :sourcepackage => @srpm.filename,
                               :arch => 'noarch' },
                             :order => 'name ASC'
      @x86_64 = Package.find :all,
                             :conditions => {
                               :branch => params[:branch],
                               :sourcepackage => @srpm.filename,
                               :arch => 'x86_64' },
                             :order => 'name ASC'
    end
  end

  def gear
    @package_counter = Srpm.count :conditions => { :branch => 'Sisyphus' }
    @srpm = Srpm.find :first,
                      :conditions => {
                        :name => params[:name],
                        :branch => params[:branch] }
    @gitrepos = Gitrepos.find :all,
                              :conditions => { :package => params[:name] },
                              :order => 'lastchange DESC'
  end

  def bugs
    @package_counter = Srpm.count :conditions => { :branch => 'Sisyphus' }
    @bugs = Bug.find :all,
                     :conditions => {
                       :component => params[:name],
                       :product => params[:branch],
                       :bug_status => ["NEW", "ASSIGNED", "VERIFIED", "REOPENED"]},
                     :order => "bug_id DESC"

    @allbugs = Bug.find :all,
                        :conditions => {
                          :component => params[:name],
                          :product => params[:branch] },
                        :order => "bug_id DESC"
  end

  def allbugs
    @package_counter = Srpm.count :conditions => { :branch => 'Sisyphus' }
    @bugs = Bug.find :all,
                     :conditions => {
                       :component => params[:name],
                       :product => params[:branch],
                       :bug_status => ["NEW", "ASSIGNED", "VERIFIED", "REOPENED"]},
                     :order => "bug_id DESC"

    @allbugs = Bug.find :all,
                        :conditions => {
                          :component => params[:name],
                          :product => params[:branch] },
                        :order => "bug_id DESC"
  end

  def repocop
    @package_counter = Srpm.count :conditions => { :branch => 'Sisyphus' }
    @srpm = Srpm.find :first,
                      :conditions => {
                        :name => params[:name],
                        :branch => params[:branch] }
    if @srpm != nil
      @reports = Repocop.find :all,
                              :conditions => {
                                :srcname => @srpm.name,
                                :srcversion => @srpm.version,
                                :srcrel => @srpm.release }
    end
  end

end
