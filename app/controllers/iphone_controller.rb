# encoding: utf-8

class IphoneController < ApplicationController
  layout "iphone"

  def index
    @maintainers = Maintainer.find_all_maintainers_in(params[:branch])
    @teams = Maintainer.find_all_teams_in(params[:branch])
    @groups = @branch.groups.where(:parent_id => nil).order('LOWER(name)')
  end

  def maintainer_info
    @branch = Branch.where(:vendor => 'ALT Linux', :name => 'Sisyphus').first
    @maintainer = Maintainer.first :conditions => {
                                   :login => params[:login].downcase,
                                   :team => false }
#    @acls = Acl.all :select => 'package',
#                    :conditions => {
#                      :login => params[:login],
#                      :branch => @branch.name,
#                      :vendor => @branch.vendor }
    @gears = Gear.where(:maintainer_id => @maintainer.id).order('LOWER(repo)')
  end

  def bygroup
    # TODO: branch can be not only Sisyphus!
    @branch = Branch.where(:vendor => 'ALT Linux', :name => 'Sisyphus').first

    @group = @branch.groups.where(:name => params[:group], :parent_id => nil).first
    if !params[:group2].nil?
      @group = @branch.groups.where(:name => params[:group2], :parent_id => @group.id).first
      if !params[:group3].nil?
        @group = @branch.groups.where(:name => params[:group3], :parent_id => @group.id).first
      end
    end
    render :status => 404, :action => 'nosuchgroup' and return if @group == nil
    @srpms = @group.srpms.find(:all, :order => 'LOWER(name)')
  end
end
