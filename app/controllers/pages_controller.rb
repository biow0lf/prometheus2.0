# frozen_string_literal: true

class PagesController < ApplicationController
  def project
    @branch = Branch.find_by!(slug: 'sisyphus')
  end
end
