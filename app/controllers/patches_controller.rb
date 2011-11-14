# encoding: utf-8

class PatchesController < ApplicationController
  def index
  end

  def show
    @patch = File.read("pmount-0.9.17-alt-floppy.patch")
  end

  def get
  end
end
