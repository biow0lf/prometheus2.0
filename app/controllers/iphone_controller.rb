class IphoneController < ApplicationController
  layout "iphone"

  def index
    @packagers = Packager.find_all_packagers_in_sisyphus
    @teams = Packager.find_all_teams_in_sisyphus
  end

end
