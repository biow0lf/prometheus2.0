class GroupController < ApplicationController
  def groups_list
    @branch = Branch.where(:name => params[:branch], :vendor => 'ALT Linux').first
    @groups = @branch.groups.where(:parent_id => nil).order('LOWER(name)')
  end

  def bygroup
    @branch = Branch.where(:name => params[:branch], :vendor => 'ALT Linux').first
    @group = @branch.groups.find(:first, :conditions => { :name => params[:group], :parent_id => nil })
    if !params[:group2].nil?
      @group = @branch.groups.find(:first, :conditions => { :name => params[:group2], :parent_id => @group.id })
      if !params[:group3].nil?
        @group = @branch.groups.find(:first, :conditions => { :name => params[:group3], :parent_id => @group.id })
      end
    end
    render :status => 404, :action => "nosuchgroup" and return if @group == nil
    @srpms = @group.srpms.find(:all, :order => 'LOWER(name)')
  end
end
