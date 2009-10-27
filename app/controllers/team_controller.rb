class TeamController < ApplicationController
  layout "default"

  def info
    @sisyphus = Branch.find :first, :conditions => { :urlname => 'Sisyphus' }
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
