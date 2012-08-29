# encoding: utf-8

class SourcesController < ApplicationController
  def index
  end

  def show
    @branch = Branch.where(name: params[:branch], vendor: 'ALT Linux').first
  end

  def get
  end
end
