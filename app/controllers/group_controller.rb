class GroupController < ApplicationController
  def index
    @branch = Branch.find_by!(name: params[:branch])
    @groups = @branch.groups.where(parent_id: nil).includes(:children).includes(children: [:children]).order('LOWER(name)')
  end

  def show
    @branch = Branch.find_by!(name: params[:branch])
    @group = @branch.groups.where(name: params[:group], parent_id: nil).first
    if !params[:group2].nil?
      @group = @branch.groups.where(name: params[:group2], parent_id: @group.id).first
      if !params[:group3].nil?
        @group = @branch.groups.where(name: params[:group3], parent_id: @group.id).first
      end
    end
    render status: 404, action: 'nosuchgroup' and return if @group == nil
    @srpms = @group.srpms.order('LOWER(name)')
  end
end
