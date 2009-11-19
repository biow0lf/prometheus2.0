class TeamController < ApplicationController
  layout "default"

  caches_page :info

  def info
    @package_counter = Srpm.count :conditions => { :branch => 'Sisyphus' }
    @branch = Branch.find :first, :conditions => { :urlname => 'Sisyphus' }
    @team = Packager.find :first,
                          :conditions => {
                            :login => '@' + params[:name],
                            :team => true }
    if @team != nil
      @members = Team.find :all,
                           :conditions => {
                             :name => '@' + params[:name],
                             :branch_id => @branch.id }
      @leader = Team.find :first,
                          :conditions => {
                            :name => '@' + params[:name],
                            :branch_id => @branch.id,
                            :leader => true }
    else
      render :action => "nosuchteam"
    end
  end

  def nosuchteam
  end
end
