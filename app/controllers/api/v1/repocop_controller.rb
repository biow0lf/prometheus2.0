class Api::V1::RepocopController < ApplicationController
  def index
    @branch = Branch.find_by_name_and_vendor!(params[:branch], 'ALT Linux')
    @repocop_testnames = Repocop.select("DISTINCT testname")
  end

  def show
    @branch = Branch.find_by_name_and_vendor!(params[:branch], 'ALT Linux')
    @repocops = Repocop.where(branch: @branch, testname: params[:testname])
  end
end
