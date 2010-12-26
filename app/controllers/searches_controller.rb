class SearchesController < ApplicationController
  def show
    @branch = Branch.where(:name => params[:branch], :vendor => 'ALT Linux').first
    if params[:query].nil? or params[:query].empty?
      redirect_to :action => "index"
    else
      @search = Srpm.search(:name_or_summary_or_description_contains_all => params[:query].to_s.split).where(:branch_id => @branch.id).order("LOWER(srpms.name) ASC")
      @srpms, @srpms_count = @search.all, @search.count
      redirect_to(srpm_path(:id => @srpms.first.name, :branch => @branch.name), :status => 302) if @search.count == 1
    end
  end
end
