class Api::V1::MaintainersController < ApplicationController
  def index
    @maintainers = Maintainer.select(:login).order(:login)
  end

  def show
    @maintainer = Maintainer.where(login: params[:login].downcase).first
  end

  def srpms
    @branch = Branch.find_by_name_and_vendor!(params[:branch], 'ALT Linux')
    @maintainer = Maintainer.where(login: params[:login].downcase).first
    @srpms = $redis.smembers("#{@branch.name}:maintainers:#{@maintainer.login}").sort
  end

  def gear
    @maintainer = Maintainer.find_by_login!(params[:login].downcase)
    @gears = Gear.where(maintainer_id: @maintainer).includes(:maintainer).order('LOWER(repo)')
  end
end
