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
      @search = Srpm.search(:name_or_summary_or_description_contains_all => params[:query].strip.to_s.split).where(:branch => @branch).includes(:branch).order("LOWER(srpms.name) ASC")
      # @srpms = Srpm.select("DISTINCT(srpms.name), LOWER(srpms.name), srpms.*").joins(:packages).where(:branch => @branch).search(:name_or_summary_or_description_or_packages_name_or_packages_summary_or_packages_description_contains_all => params[:query].strip.to_s.split).order("LOWER(srpms.name) ASC")
      # @srpms_count = Srpm.select("COUNT(DISTINCT(srpms.name)) AS count_all").joins(:packages).where(:branch => @branch).search(:name_or_summary_or_description_or_packages_name_or_packages_summary_or_packages_description_contains_all => params[:query].strip.to_s.split).first
      @srpms, @srpms_count = @search.all, @search.count
      # @srpms = @search.all
      redirect_to(srpm_path(@branch, @srpms.first), :status => 302) if @srpms.length == 1
    end
  end
end
