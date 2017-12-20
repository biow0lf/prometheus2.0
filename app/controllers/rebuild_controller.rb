# frozen_string_literal: true

class RebuildController < ApplicationController
  def index
    @specfiles = Specfile.where('spec LIKE ?', '%undefine _configure_target%').includes(srpm: [:branch, :maintainer, [acls: :maintainer]])
  end
end
