# encoding: utf-8

class MaintainersController < ApplicationController
  # helper_method :sort_column, :sort_direction

  def show
    @branch = Branch.where(name: params[:branch], vendor: 'ALT Linux').first
    @branches = Branch.order('order_id').all
    @maintainer = Maintainer.where(login: params[:id].downcase).first
    render(status: 404, action: 'nosuchmaintainer') and return if @maintainer == nil
    @acls = $redis.smembers("#{@branch.name}:maintainers:#{params[:id].downcase}").count
  end

  def srpms
    @branch = Branch.where(name: params[:branch], vendor: 'ALT Linux').first
    @maintainer = Maintainer.where(login: params[:id].downcase).first
    render(status: 404, action: 'nosuchmaintainer') and return if @maintainer == nil
    @srpms = @branch.srpms.where(name: $redis.smembers("#{@branch.name}:maintainers:#{@maintainer.login}")).includes(:repocop_patch).order('LOWER(srpms.name)')
  end

#  def acls
#    @branch = Branch.where(:name => params[:branch], :vendor => "ALT Linux").first
#    @maintainer = Maintainer.first :conditions => {
#                                     :login => params[:id].downcase }
#    @acls = Acl.all :conditions => {
#                      :login => params[:login],
#                      :branch_id => @branch.id }
#    if @maintainer == nil
#      render :status => 404, :action => "nosuchmaintainer"
#    end
#  end

  def gear
    @maintainer = Maintainer.where(login: params[:id].downcase).first
    render(status: 404, action: 'nosuchmaintainer') and return if @maintainer == nil
    @gears = Gear.where(maintainer_id: @maintainer).includes(:maintainer).order('LOWER(repo)')
  end

  def bugs
    @maintainer = Maintainer.where(login: params[:id].downcase).first
    render(status: 404, action: 'nosuchmaintainer') and return if @maintainer == nil
    @bugs = Bug.where(assigned_to: "#{params[:id].downcase}@altlinux.org",
                      product: 'Sisyphus',
                      bug_status: ['NEW', 'ASSIGNED', 'VERIFIED', 'REOPENED']).order('bug_id DESC')
    @allbugs = Bug.where(assigned_to: "#{params[:id].downcase}@altlinux.org",
                         product: 'Sisyphus').order('bug_id DESC')
  end

  def allbugs
    @maintainer = Maintainer.where(login: params[:id].downcase).first
    render(status: 404, action: 'nosuchmaintainer') and return if @maintainer == nil
    @bugs = Bug.where(assigned_to: "#{params[:id].downcase}@altlinux.org",
                      product: 'Sisyphus',
                      bug_status: ['NEW', 'ASSIGNED', 'VERIFIED', 'REOPENED']).order('bug_id DESC')
    @allbugs = Bug.where(assigned_to: "#{params[:id].downcase}@altlinux.org",
                         product: 'Sisyphus').order('bug_id DESC')
  end

  def ftbfs
    @branch = Branch.where(name: params[:branch], vendor: 'ALT Linux').first
    @maintainer = Maintainer.where(login: params[:id].downcase).first
    render(status: 404, action: 'nosuchmaintainer') and return if @maintainer == nil
    @ftbfs = Ftbfs.where(maintainer_id: @maintainer).includes(:branch)
  end

  def repocop
    @branch = Branch.where(vendor: 'ALT Linux', name: 'Sisyphus').first
    @maintainer = Maintainer.where(login: params[:id].downcase).first
    render(status: 404, action: 'nosuchmaintainer') and return if @maintainer == nil
    @srpms = @branch.srpms.where(name: $redis.smembers("#{@branch.name}:maintainers:#{@maintainer.login}")).includes(:repocops).order('LOWER(srpms.name)')
  end

  # private
  # 
  # def sort_column
  #   %w[srpms.name srpms.repocop].include?(params[:sort]) ? params[:sort] : 'srpms.name'
  # end
  # 
  # def sort_direction
  #   %w[asc desc].include?(params[:direction]) ?  params[:direction] : 'asc'
  # end
end
