# frozen_string_literal: true

class SearchesController < ApplicationController
  before_action :fix_arches

  def show
    @branches = Branch.order('order_id')
    if params[:query].blank? and params[:arch].blank?
      redirect_to controller: 'home', action: 'index'
    else
      @spkgs = Package.b(params[:branch]).a(@arches).q(params[:query]).reorder("packages.name").distinct.page(params[:page])
      # @srpms = Srpm.none
      # @srpms = Srpm.search(
      #   Riddle::Query.escape(params[:query]),
      #   order: :name,
      #   max_matches: 10_000,
      #   per_page: 100,
      #   field_weights: {
      #     name: 10,
      #     summary: 9,
      #     url: 9,
      #     description: 8
      #   },
      #   with: { branch_id: @branch.id },
      #   include: :branch
      # ).page(params[:page]).per(100)

      if @spkgs.total_count == 1
        redirect_to(srpm_path(@branch, @spkgs.first), status: 302)
      end
    end
  # rescue Mysql2::Error
  #   render 'search_is_not_available'
  # rescue ThinkingSphinx::ConnectionError
  #   render 'search_is_not_available'
  end

  protected

  # fixes noarch arch call when blank TODO
  def fix_arches
    arches = [ params[:arch] ].flatten.compact.select { |a| a.present? }
    @arches = arches.any? { |a| a != 'noarch' } && arches || nil
  end
end
