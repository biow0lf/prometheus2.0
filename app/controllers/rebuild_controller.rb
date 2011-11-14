# encoding: utf-8

class RebuildController < ApplicationController
  def index
    @specfiles = Specfile.where("spec LIKE ?", '%undefine _configure_target%').includes(:srpm => [:branch, :leader, :maintainer, [:acls => :maintainer]])
  end
end
