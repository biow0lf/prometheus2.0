class PatchesController < ApplicationController
  def index
  end

  def show
    @branch = Branch.where(name: params[:branch], vendor: 'ALT Linux').first
    @patch = File.read("pmount-0.9.17-alt-floppy.patch")
  end

  def get
  end
end
