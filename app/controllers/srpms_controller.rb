class SrpmsController < ApplicationController
  def show
    @srpm_show = SrpmShow.new(params[:branch], params[:id])
    render status: 404, action: 'nosuchpackage' and return unless @srpm_show.srpm
#    @contributors = Srpm.contributors(@branch, @srpm)
  end

  def changelog
    @branch = Branch.find_by_name_and_vendor!(params[:branch], 'ALT Linux')
    @srpm = @branch.srpms.where(name: params[:id]).includes(:branch).first
    render status: 404, action: 'nosuchpackage' and return unless @srpm
    @changelogs = @srpm.changelogs.order('changelogs.created_at ASC')
    @allsrpms = Srpm.where(name: params[:id]).includes(:branch).order('branches.order_id')
  end

  def spec
    @branch = Branch.find_by_name_and_vendor!(params[:branch], 'ALT Linux')
    @srpm = @branch.srpms.where(name: params[:id]).includes(:branch).first
    render status: 404, action: 'nosuchpackage' and return unless @srpm
    @allsrpms = Srpm.where(name: params[:id]).includes(:branch).order('branches.order_id')
  end

  def rawspec
    @branch = Branch.find_by_name_and_vendor!(params[:branch], 'ALT Linux')
    @srpm = @branch.srpms.where(name: params[:id]).includes(:group, :branch).first
    render status: 404, action: 'nosuchpackage' and return unless @srpm
    if @srpm.specfile
      send_data @srpm.specfile.spec, disposition: 'attachment', type: 'text/plain', filename: "#{@srpm.name}.spec"
    else @srpm.specfile == nil
      render layout: false
    end
  end

  def get
    @srpm_get = SrpmGet.new(params[:branch], params[:id])
    render status: 404, action: 'nosuchpackage' and return unless @srpm_get.srpm
  end

  def gear
    @branch = Branch.find_by_name_and_vendor!(params[:branch], 'ALT Linux')
    @srpm = @branch.srpms.where(name: params[:id]).includes(:branch).first
    render status: 404, action: 'nosuchpackage' and return unless @srpm

    # TODO: use srpm_id !
    @gears = Gear.where(repo: params[:id]).includes(:maintainer).order('lastchange DESC')
  end

  def bugs
    @srpm_bug = SrpmBug.new(params[:branch], params[:id])
    render status: 404, action: 'nosuchpackage' and return unless @srpm_bug.srpm
  end

  def allbugs
    @srpm_bug = SrpmBug.new(params[:branch], params[:id])
    render status: 404, action: 'nosuchpackage' and return unless @srpm_bug.srpm
  end

  def repocop
    @branch = Branch.find_by_name_and_vendor!(params[:branch], 'ALT Linux')
    @srpm = @branch.srpms.where(name: params[:id]).includes(:branch).first
    render status: 404, action: 'nosuchpackage' and return unless @srpm
    @repocops = Repocop.where(srcname: @srpm.name,
                              srcversion: @srpm.version,
                              srcrel: @srpm.release)
  end
end
