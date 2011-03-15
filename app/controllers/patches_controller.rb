class PatchesController < ApplicationController
  def index
  end

  def show
    @patch = File.read("pmount-0.9.19-alt-ext4.patch")
  end

  def get
  end
end
