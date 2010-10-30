class RedirectorController < ApplicationController
  def index
    @branch = Branch.where(:name => 'Sisyphus', :vendor => 'ALT Linux').first
    @package = @branch.packages.where(:name => params[:name]).first
    if !@package.nil?
      redirect_to '/en/srpm/Sisyphus/' + @package.srpm.name, 302
    else
      redirect_to '/en/srpm/Sisyphus/' + params[:name], 302
    end
  end
end