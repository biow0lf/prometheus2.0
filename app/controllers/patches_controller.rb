class PatchesController < ApplicationController
  layout nil

  def index
  end

  def show
    @udiff = File.read("pmount-0.9.19-alt-ext4.patch")
    @pretty = PrettyDiff::Diff.new(@udiff)
    # @pretty.to_html
  end

  def get
  end
end
