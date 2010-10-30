class RedirectorController < ApplicationController
  def index
    @branch = Branch.where(:name => 'Sisyphus', :vendor => 'ALT Linux').first
    @package = @branch.packages.where(:name => params[:name]).first
    if !@package.nil?
      redirect_to srpm_main_path(:name => @package.srpm.name, :branch => 'Sisyphus'), :status => 302
    else
      redirect_to srpm_main_path(:name => params[:name], :branch => 'Sisyphus'), :status => 302
    end
  end
end