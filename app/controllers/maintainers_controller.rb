class MaintainersController < ApplicationController
  def show
    @branch = Branch.find_by_name_and_vendor!(params[:branch], 'ALT Linux')
    @branches = Branch.order('order_id').all
    @maintainer = Maintainer.find_by_login!(params[:id].downcase)
    @acls = $redis.smembers("#{@branch.name}:maintainers:#{params[:id].downcase}").count
  end

  def srpms
    @branch = Branch.find_by_name_and_vendor!(params[:branch], 'ALT Linux')
    @branches = Branch.order('order_id').all
    @maintainer = Maintainer.find_by_login!(params[:id].downcase)

    order  = ""
    order += "LOWER(srpms.name)" if sort_column == 'name'
    order += "buildtime" if sort_column == 'age'

    if sort_column == 'status'
      order += "CASE repocop
                WHEN 'skip'         THEN 1
                WHEN 'ok'           THEN 2
                WHEN 'experimental' THEN 3
                WHEN 'info'         THEN 4
                WHEN 'warn'         THEN 5
                WHEN 'fail'         THEN 6
                END"
    end

    order += " " + sort_order

    @srpms = @branch.srpms.where(name: $redis.smembers("#{@branch.name}:maintainers:#{@maintainer.login}")).
                           includes(:repocop_patch).order(order).decorate
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
    @maintainer = Maintainer.find_by_login!(params[:id].downcase)
    @gears = Gear.where(maintainer_id: @maintainer).includes(:maintainer).order('LOWER(repo)')
  end

  def bugs
    # TODO: add Branch support
    # @branch = Branch.find_by_name_and_vendor!(params[:branch], 'ALT Linux')
    @branch = Branch.find_by_name_and_vendor!('Sisyphus', 'ALT Linux')
    @maintainer = Maintainer.find_by_login!(params[:id].downcase)
    @srpms = @branch.srpms.where(name: $redis.smembers("#{@branch.name}:maintainers:#{@maintainer.login}")).includes(:packages)

    names = @srpms.map { |srpm| srpm.packages.map { |package| package.name } }.flatten.sort.uniq

    @bugs = Bug.where('component IN (?) OR assigned_to = ?', names, @maintainer.email).
                where(bug_status: ['NEW', 'ASSIGNED', 'VERIFIED', 'REOPENED']).
                order('bug_id DESC')

    @allbugs = Bug.where('component IN (?) OR assigned_to = ?', names, @maintainer.email).
                   order('bug_id DESC')
  end

  def allbugs
    # TODO: add Branch support
    # @branch = Branch.find_by_name_and_vendor!(params[:branch], 'ALT Linux')
    @branch = Branch.find_by_name_and_vendor!('Sisyphus', 'ALT Linux')
    @maintainer = Maintainer.find_by_login!(params[:id].downcase)
    @srpms = @branch.srpms.where(name: $redis.smembers("#{@branch.name}:maintainers:#{@maintainer.login}")).includes(:packages)

    names = @srpms.map { |srpm| srpm.packages.map { |package| package.name } }.flatten.sort.uniq

    @bugs = Bug.where('component IN (?) OR assigned_to = ?', names, @maintainer.email).
                where(bug_status: ['NEW', 'ASSIGNED', 'VERIFIED', 'REOPENED']).
                order('bug_id DESC')

    @allbugs = Bug.where('component IN (?) OR assigned_to = ?', names, @maintainer.email).
                   order('bug_id DESC')
  end

  def ftbfs
    @branch = Branch.find_by_name_and_vendor!(params[:branch], 'ALT Linux')
    @maintainer = Maintainer.find_by_login!(params[:id].downcase)
    @ftbfs = Ftbfs.where(maintainer_id: @maintainer).includes(:branch)
  end

  def repocop
    @branch = Branch.find_by_name_and_vendor!(params[:branch], 'ALT Linux')
    @maintainer = Maintainer.find_by_login!(params[:id].downcase)
    @srpms = @branch.srpms.where(name: $redis.smembers("#{@branch.name}:maintainers:#{@maintainer.login}")).includes(:repocops).order('LOWER(srpms.name)')
  end
end
