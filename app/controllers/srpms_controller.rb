class SrpmsController < ApplicationController

  def show
    @srpm = @branch.srpms.where(:name => params[:id]).includes(:packages, :group, :branch, :leader, :maintainer, :acls).first
    if @srpm != nil
      @allsrpms = Srpm.where(:name => params[:id]).joins(:branch).order('branches.order_id')

#      @i586 = @srpm.packages.where(:arch => 'i586').order('packages.name ASC')
#      @noarch = @srpm.packages.where(:arch => 'noarch').order('packages.name ASC')
#      @x86_64 = @srpm.packages.where(:arch => 'x86_64').order('packages.name ASC')
#      @arm = @srpm.packages.where(:arch => 'arm').order('packages.name ASC')
    else
      render :status => 404, :action => 'nosuchpackage'
    end
  end

  def changelog
    @branch = Branch.where(:vendor => 'ALT Linux', :name => params[:branch]).first
    @srpm = @branch.srpms.where(:name => params[:id]).includes(:group, :branch).first
    if @srpm != nil
      @changelogs = @srpm.changelogs.order('changelogs.created_at ASC')
      @allsrpms = Srpm.where(:name => params[:id]).joins(:branch).order('branches.order_id')
    else
      render :status => 404, :action => 'nosuchpackage'
    end
  end

  def spec
    @srpm = @branch.srpms.where(:name => params[:id]).includes(:group, :branch).first
    if @srpm != nil
      @allsrpms = Srpm.where(:name => params[:id]).joins(:branch).order('branches.order_id')
    else
      render :status => 404, :action => 'nosuchpackage'
    end
  end

  def rawspec
    @srpm = @branch.srpms.where(:name => params[:id]).includes(:group, :branch).first
    if @srpm != nil && @srpm.specfile_id != nil
      send_data @srpm.specfile.spec, :type => 'text/plain', :filename => "#{@srpm.name}.spec"
    elsif @srpm != nil && @srpm.specfile_id == nil
      render :layout => false
    else
      render :status => 404, :action => 'nosuchpackage'
    end
  end

#   def patches
#     @udiff = File.read("pmount-0.9.19-alt-ext4.patch")
#     @pretty = PrettyDiff::Diff.new(@udiff)
# #    @pretty.to_html
#   end

  def get
    @mirrors = Mirror.where(:branch_id => @branch.id).where(:protocol ^ 'rsync').order('mirrors.order_id ASC')
    @srpm = @branch.srpms.where(:name => params[:id]).includes(:group, :branch, :packages).first
    if @srpm != nil
      @allsrpms = Srpm.where(:name => params[:id]).joins(:branch).order('branches.order_id')
      @i586 = @srpm.packages.where(:arch => 'i586').order('packages.name ASC')
      @noarch = @srpm.packages.where(:arch => 'noarch').order('packages.name ASC')
      @x86_64 = @srpm.packages.where(:arch => 'x86_64').order('packages.name ASC')
      @arm = @srpm.packages.where(:arch => 'arm').order('packages.name ASC')
    else
      render :status => 404, :action => 'nosuchpackage'
    end
  end

  def gear
    @branch = Branch.where(:vendor => 'ALT Linux', :name => params[:branch]).first
    @srpm = @branch.srpms.where(:name => params[:id]).includes(:group, :branch).first

    if @srpm != nil
#      @gitrepos = Gitrepo.all :conditions => { :repo => @srpm.name },
#                               :order => 'lastchange DESC'
#      @gitrepos = Gitrepo.all :conditions => {
#                                :srpm_id => @srpm.id },
#                              :order => 'lastchange DESC'
# TODO: use srpm_id !
      @gitrepos = Gitrepo.all :conditions => {
                                :repo => params[:id] },
                              :order => 'gitrepos.lastchange DESC'
    else
      render :status => 404, :action => "nosuchpackage"
    end
  end

  def bugs
    # TODO: search for bugs not only by srpm.name, but and by packages.name
    @branch = Branch.where(:vendor => 'ALT Linux', :name => params[:branch]).first
    @srpm = @branch.srpms.where(:name => params[:id]).includes(:group, :branch).first

    @bugs = Bug.where(:component => params[:id],
                      :bug_status => ["NEW", "ASSIGNED", "VERIFIED", "REOPENED"]
                      ).order("bug_id DESC")

    @allbugs = Bug.where(:component => params[:id]).order("bug_id DESC")
    if @srpm == nil
      render :status => 404, :action => "nosuchpackage"
    end
  end

  def allbugs
    # TODO: search for bugs not only by srpm.name, but and by packages.name
    @branch = Branch.where(:vendor => 'ALT Linux', :name => params[:branch]).first
    @srpm = @branch.srpms.where(:name => params[:id]).includes(:group, :branch).first

    @bugs = Bug.where(:component => params[:id],
                      :bug_status => ["NEW", "ASSIGNED", "VERIFIED", "REOPENED"]
                      ).order("bug_id DESC")

    @allbugs = Bug.where(:component => params[:id]).order("bug_id DESC")
    if @srpm == nil
      render :status => 404, :action => "nosuchpackage"
    end
  end

  def repocop
    @branch = Branch.where(:vendor => 'ALT Linux', :name => params[:branch]).first
    @srpm = @branch.srpms.where(:name => params[:id]).includes(:group, :branch).first
    if @srpm != nil
      @repocops = Repocop.where(:srcname => @srpm.name,
                                :srcversion => @srpm.version,
                                :srcrel => @srpm.release)
    else
      render :status => 404, :action => "nosuchpackage"
    end
  end
end