class GroupController < ApplicationController
  def index
    @branch = Branch.find_by!(name: params[:branch])
    @groups = @branch.groups.where(parent_id: nil).includes(:children).includes(children: [:children]).order('LOWER(name)')
  end

  def show
    @branch = Branch.find_by!(name: params[:branch])
    @group = @branch.groups.find_by!(name: params[:group], parent_id: nil)
    if !params[:group2].nil?
      @group = @branch.groups.find_by!(name: params[:group2], parent_id: @group.id)
      if !params[:group3].nil?
        @group = @branch.groups.find_by!(name: params[:group3], parent_id: @group.id)
      end
    end
    @srpms = @group.srpms.order('LOWER(name)').decorate
  end
end
