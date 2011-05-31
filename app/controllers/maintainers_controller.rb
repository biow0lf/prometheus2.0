class MaintainersController < ApplicationController
  def show
    @branch = Branch.where(:name => params[:branch], :vendor => 'ALT Linux').first
    @maintainer = Maintainer.where(:login => params[:id].downcase, :team => false).first
    render(:status => 404, :action => 'nosuchmaintainer') and return if @maintainer == nil
    @acls = Acl.where(:maintainer => @maintainer, :branch => @branch)
  end

  def srpms
    @branch = Branch.where(:name => params[:branch], :vendor => 'ALT Linux').first
    @maintainer = Maintainer.where(:login => params[:id].downcase, :team => false).first
    render(:status => 404, :action => 'nosuchmaintainer') and return if @maintainer == nil
    @acls = Acl.where(:maintainer => @maintainer, :branch => @branch).includes(:srpm => [:repocop_patch]).order('LOWER(srpms.name)')
  end

#  def acls
#    @branch = Branch.where(:name => params[:branch], :vendor => "ALT Linux").first
#    @maintainer = Maintainer.first :conditions => {
#                                     :login => params[:id].downcase,
#                                     :team => false }
#    @acls = Acl.all :conditions => {
#                      :login => params[:login],
#                      :branch_id => @branch.id }
#    if @maintainer == nil
#      render :status => 404, :action => "nosuchmaintainer"
#    end
#  end

  def gear
    @maintainer = Maintainer.where(:login => params[:id].downcase, :team => false).first
    render(:status => 404, :action => 'nosuchmaintainer') and return if @maintainer == nil
    @gears = Gear.where(:maintainer => @maintainer).order('LOWER(repo)')
  end

  def bugs
    @maintainer = Maintainer.where(:login => params[:id].downcase, :team => false).first
    render(:status => 404, :action => 'nosuchmaintainer') and return if @maintainer == nil
    @bugs = Bug.where(:assigned_to => "#{params[:id].downcase}@altlinux.org",
                      :product => 'Sisyphus',
                      :bug_status => ['NEW', 'ASSIGNED', 'VERIFIED', 'REOPENED']).order('bug_id DESC')
    @allbugs = Bug.where(:assigned_to => "#{params[:id].downcase}@altlinux.org",
                         :product => 'Sisyphus').order('bug_id DESC')
  end

  def allbugs
    @maintainer = Maintainer.where(:login => params[:id].downcase, :team => false).first
    render(:status => 404, :action => 'nosuchmaintainer') and return if @maintainer == nil
    @bugs = Bug.where(:assigned_to => "#{params[:id].downcase}@altlinux.org",
                      :product => 'Sisyphus',
                      :bug_status => ['NEW', 'ASSIGNED', 'VERIFIED', 'REOPENED']).order('bug_id DESC')
    @allbugs = Bug.where(:assigned_to => "#{params[:id].downcase}@altlinux.org",
                         :product => 'Sisyphus').order('bug_id DESC')
  end

  def repocop
    @branch = Branch.where(:vendor => 'ALT Linux', :name => 'Sisyphus').first
    @maintainer = Maintainer.where(:login => params[:id].downcase, :team => false).includes(:srpms).order('LOWER(srpms.name)').first
    render(:status => 404, :action => 'nosuchmaintainer') and return if @maintainer == nil
    @srpms = @maintainer.srpms.where(:branch => @branch).includes(:repocops)
  end
end
