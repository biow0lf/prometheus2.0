# encoding: utf-8

class RedirectorController < ApplicationController
  def index
    @branch = Branch.where(name: 'Sisyphus', vendor: 'ALT Linux').first
    @package = @branch.packages.where(name: params[:name]).first
    if @package
      redirect_to srpm_path('Sisyphus', @package.srpm), status: 302
    else
      redirect_to srpm_path('Sisyphus', params[:name]), status: 302
    end
  end
end
