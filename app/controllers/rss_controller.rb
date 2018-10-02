# frozen_string_literal: true

class RssController < ApplicationController
  def index
    @srpms = @branch.spkgs.where('packages.buildtime > ?', Time.zone.now - 2.days).order('packages.buildtime DESC, packages.updated_at DESC').decorate
    render layout: nil
    response.headers['Content-Type'] = 'application/xml; charset=utf-8'
  end
end
