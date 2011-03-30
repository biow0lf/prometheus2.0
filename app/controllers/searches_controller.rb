class SearchesController < ApplicationController
  def show
    unless params[:branch_id].blank?
      @branch = Branch.where(:id => params[:branch_id], :vendor => 'ALT Linux').first
    else
      @branch = Branch.where(:name => params[:branch], :vendor => 'ALT Linux').first
    end
    @branches = Branch.all
    if params[:query].nil? or params[:query].empty?
      redirect_to :action => 'index'
    else
      @srpms = Srpm.search(params[:query], :order => :name, :max_matches => 10_000, :per_page => 10_000, :with => { :branch_id => @branch.id }, :include => :branch)
      redirect_to(srpm_path(@branch, @srpms.first), :status => 302) if @srpms.count == 1
    end
  end
end
