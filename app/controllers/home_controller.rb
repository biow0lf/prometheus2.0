# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @branches = Branch.filled.order('order_id')
    @srpm_builds = @branch.all_spkgs.top_rebuilds_after(Time.zone.now - 6.months).limit(16)
    @branches_s = BranchPathsToBranchesSerializer.new(BranchPath.includes(:branch).for_branch(@branches).unanonimous.src.order("branches.order_id, branch_paths.id"))
    @maintainers_s = ActiveModel::Serializer::CollectionSerializer.new(BranchingMaintainer.includes(:maintainer).top(15, @branch), serializer: BranchingMaintainerAsMaintainerSerializer).as_json
    @srpms = @branch.spkgs.includes(:builder).ordered.page(params[:page]).per(40).decorate
  end
end
