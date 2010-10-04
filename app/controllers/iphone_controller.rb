class IphoneController < ApplicationController
  layout "iphone"

  def index
    @packagers = Maintainer.find_all_maintainers_in_sisyphus
    @teams = Maintainer.find_all_teams_in_sisyphus
    @groups = Group.find_groups_in_sisyphus
  end

  def packager_info
    @branch = Branch.first :conditions => {
                             :vendor => 'ALT Linux',
                             :name => 'Sisyphus' }
    @packager = Maintainer.first :conditions => {
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
end