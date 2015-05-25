class RsyncController < ApplicationController
  def new
    @branch = Branch.find_by!(name: 'Sisyphus')
    @groups = @branch.groups.where(parent_id: nil).order('LOWER(name)')
  end
end
