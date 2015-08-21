class SearchesController < ApplicationController
  def show
    @branch = Branch.find_by!(name: params[:branch])
    @branches = Branch.order('order_id')
    if params[:query].blank?
      redirect_to controller: 'home', action: 'index'
    else
      @srpms = SrpmDecorator.decorate_collection(Srpm.search(
        Riddle::Query.escape(params[:query]),
        order: :name,
        max_matches: 10_000,
        per_page: 10_000,
        field_weights: {
          name: 10,
          summary: 9,
          url: 9,
          description: 8
        },
        with: { branch_id: @branch.id },
        include: :branch
      ))
      redirect_to(srpm_path(@branch, @srpms.first), status: 302) if @srpms.count == 1
    end
  rescue Mysql2::Error
    render 'search_is_not_available'
  end
end
