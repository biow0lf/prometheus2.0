# frozen_string_literal: true

class SearchesController < ApplicationController
  def show
    @branches = Branch.order('order_id')
    if params[:query].blank? and params[:arch].blank?
      redirect_to controller: 'home', action: 'index'
    else
      @srpms = Srpm.b(params[:branch]).q(params[:query])

      srpm_ids = @srpms.group_by {|s| s.name}.map {|(_, s)| s.last.id } #TODO remove

      #TODO remove
      @srpms = Srpm.b(params[:branch]).a(params[:arch])
      if params[:query].present?
        @srpms = @srpms.where(id: srpm_ids).q(params[:query])
      end
      @srpms = @srpms.page(params[:page]).reorder("srpms.name").distinct
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
      if @srpms.count == 1
        redirect_to(srpm_path(@branch, @srpms.first), status: 302)
      end
    end
  # rescue Mysql2::Error
  #   render 'search_is_not_available'
  # rescue ThinkingSphinx::ConnectionError
  #   render 'search_is_not_available'
  end
end
