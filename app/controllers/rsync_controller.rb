# encoding: utf-8

class RsyncController < ApplicationController
  def new
    @branch = Branch.where(name: 'Sisyphus', vendor: 'ALT Linux').first
    @groups = @branch.groups.where(parent_id: nil).order('LOWER(name)')
  end
end
