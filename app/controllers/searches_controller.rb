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
      @exact_srpm = Srpm.where(:name => params[:query].strip, :branch => @branch).first
      @search = Srpm.search(:name_or_summary_or_description_contains_all => params[:query].strip.to_s.split).where(:branch => @branch).order("LOWER(srpms.name) ASC")
      @srpms, @srpms_count = @search.all, @search.count
      redirect_to(srpm_path(@branch, @srpms.first), :status => 302) if @search.count == 1
    end
  end
end
