# encoding: utf-8

class SearchesController < ApplicationController
  def show
    @branch = Branch.where(name: params[:branch], vendor: 'ALT Linux').first
    @branches = Branch.order('order_id').all
    if params[:query].nil? || params[:query].empty?
      redirect_to action: 'index'
    else
      @srpms = Srpm.search(params[:query], :order => :name, :max_matches => 10_000, :per_page => 10_000, :with => { :branch_id => @branch.id }, :include => :branch).page(params[:page]).per(500)
      redirect_to(srpm_path(@branch, @srpms.first), status: 302) if @srpms.count == 1
    end
  end
end
