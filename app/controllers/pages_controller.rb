# frozen_string_literal: true

class PagesController < ApplicationController
  def project
    @branch = Branch.find_by!(name: 'Sisyphus')
  end
end
