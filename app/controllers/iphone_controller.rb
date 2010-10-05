class IphoneController < ApplicationController
  layout "iphone"

  def index
    @maintainers = Maintainer.find_all_maintainers_in_sisyphus
    @teams = Maintainer.find_all_teams_in_sisyphus
    @groups = Group.find_groups_in_sisyphus
  end

  def maintainer_info
    @branch = Branch.first :conditions => {
                             :vendor => 'ALT Linux',
                             :name => 'Sisyphus' }
    @maintainer = Maintainer.first :conditions => {
                                   :login => params[:login].downcase,
                                   :team => false }
#    @acls = Acl.all :select => 'package',
#                    :conditions => {
#                      :login => params[:login],
#                      :branch => @branch.name,
#                      :vendor => @branch.vendor }
    @gitrepos = Gitrepo.all :conditions => {
                              :login => params[:login].downcase },
                            :order => 'repo ASC'

  end

  def bygroup
    # TODO: branch can be not only Sisyphus!
    @branch = Branch.first :conditions => { :vendor => 'ALT Linux', :name => 'Sisyphus' }

    groupname = params[:group]
    groupname = groupname + '/' + params[:group2] if !params[:group2].nil?
    groupname = groupname + '/' + params[:group3] if !params[:group3].nil?

    @group = Group.first :conditions => {
                               :name => groupname,
                               :branch_id => @branch.id }
    @srpms = Srpm.all :conditions => {
                        :group_id => @group.id,
                        :branch_id => @branch.id },
                      :order => 'LOWER(name)'
  end
end