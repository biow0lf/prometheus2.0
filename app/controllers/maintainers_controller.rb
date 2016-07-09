class MaintainersController < ApplicationController
  def index
    @branch = Branch.find_by!(name: params[:branch])
    @branches = Branch.order('order_id')
    @maintainers = Maintainer.order(:name)
  end

  def show
    @branch = Branch.find_by!(name: params[:branch])
    @maintainer = Maintainer.find_by!(login: params[:id].downcase).decorate
    @branches = Branch.order('order_id')
    # TODO: move @acls to maintainer or branch...
    @acls = Redis.current.smembers("#{ @branch.name }:maintainers:#{ params[:id].downcase }").count
    @all_bugs = AllBugsForMaintainer.new(@branch, @maintainer).decorate
    @opened_bugs = OpenedBugsForMaintainer.new(@branch, @maintainer).decorate
  end

  def srpms
    @branch = Branch.find_by!(name: params[:branch])
    @maintainer = Maintainer.find_by!(login: params[:id].downcase)
    @branches = Branch.order('order_id')

    order  = ''
    order += 'LOWER(srpms.name)' if sort_column == 'name'
    order += 'buildtime' if sort_column == 'age'

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

    order += ' ' + sort_order

    @srpms = @branch.srpms.where(name: Redis.current.smembers("#{ @branch.name }:maintainers:#{ @maintainer.login }")).
                           includes(:repocop_patch).
                           order(order).decorate

    @all_bugs = AllBugsForMaintainer.new(@branch, @maintainer).decorate
    @opened_bugs = OpenedBugsForMaintainer.new(@branch, @maintainer).decorate
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
    @branch = Branch.find_by!(name: 'Sisyphus')
    @maintainer = Maintainer.find_by!(login: params[:id].downcase)
    @gears = Gear.where(maintainer_id: @maintainer).includes(:maintainer).order('LOWER(repo)')
    @all_bugs = AllBugsForMaintainer.new(@branch, @maintainer).decorate
    @opened_bugs = OpenedBugsForMaintainer.new(@branch, @maintainer).decorate
  end

  def bugs
    # TODO: add Branch support
    # @branch = Branch.find_by!(name: params[:branch])
    @branch = Branch.find_by!(name: 'Sisyphus')
    @maintainer = Maintainer.find_by!(login: params[:id].downcase)
    @srpms = @branch.srpms.where(name: Redis.current.smembers("#{ @branch.name }:maintainers:#{ @maintainer.login }")).includes(:packages)
    @all_bugs = AllBugsForMaintainer.new(@branch, @maintainer).decorate
    @opened_bugs = OpenedBugsForMaintainer.new(@branch, @maintainer).decorate
  end

  def allbugs
    # TODO: add Branch support
    # @branch = Branch.find_by!(name: params[:branch])
    @branch = Branch.find_by!(name: 'Sisyphus')
    @maintainer = Maintainer.find_by!(login: params[:id].downcase)
    @srpms = @branch.srpms.where(name: Redis.current.smembers("#{ @branch.name }:maintainers:#{ @maintainer.login }")).includes(:packages)
    @all_bugs = AllBugsForMaintainer.new(@branch, @maintainer).decorate
    @opened_bugs = OpenedBugsForMaintainer.new(@branch, @maintainer).decorate
  end

  def ftbfs
    @branch = Branch.find_by!(name: params[:branch])
    @maintainer = Maintainer.find_by!(login: params[:id].downcase)
    @ftbfs = Ftbfs.where(maintainer_id: @maintainer).includes(:branch)
    @all_bugs = AllBugsForMaintainer.new(@branch, @maintainer).decorate
    @opened_bugs = OpenedBugsForMaintainer.new(@branch, @maintainer).decorate
  end

  def repocop
    @branch = Branch.find_by!(name: params[:branch])
    @maintainer = Maintainer.find_by!(login: params[:id].downcase)
    @srpms = @branch.srpms.where(name: Redis.current.smembers("#{ @branch.name }:maintainers:#{ @maintainer.login }")).includes(:repocops).order('LOWER(srpms.name)')
    @all_bugs = AllBugsForMaintainer.new(@branch, @maintainer).decorate
    @opened_bugs = OpenedBugsForMaintainer.new(@branch, @maintainer).decorate
  end
end
