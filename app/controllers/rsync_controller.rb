class RsyncController < ApplicationController
  def new
    @branch = Branch.where(name: 'Sisyphus').first
    @groups = @branch.groups.where(parent_id: nil).order('LOWER(name)')
  end
end
