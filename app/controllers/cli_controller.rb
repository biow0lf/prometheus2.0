class CliController < ApplicationController
  layout nil

  def srpm_info
    @branch = Branch.where(:name => params[:branch], :vendor => params[:vendor]).first
    @srpm = Srpm.where(:name => params[:name], :branch_id => @branch.id).first
  end
end