# frozen_string_literal: true

class PatchesController < ApplicationController
  before_action :fetch_srpms_by_name, only: %i(index)

  def index
    @branch = Branch.find_by!(name: params[:branch])
    @srpm = @branch.srpms.where(name: params[:srpm_id]).includes(:patches).first!
    @all_bugs = AllBugsForSrpm.new(@srpm).decorate
    @opened_bugs = OpenedBugsForSrpm.new(@srpm).decorate
  end

  def show
    @branch = Branch.find_by!(name: params[:branch])
    @srpm = @branch.srpms.find_by!(name: params[:srpm_id])
    @patch = @srpm.patches.find_by!(filename: params[:id])
    raise ActiveRecord::RecordNotFound unless @patch.patch
    # @html_data = Rouge::Formatters::HTML.new(css_class: 'highlight', line_numbers: true, inline_theme: 'github').format(Rouge::Lexers::Diff.new.lex(@patch.patch))

    @html_data = Rouge::Formatters::HTMLLegacy.new(css_class: 'highlight', line_numbers: true).format(Rouge::Lexers::Diff.new.lex(@patch.patch))
  end

  protected

  def fetch_srpms_by_name
    @srpms_by_name = SrpmBranchesSerializer.new(NamedSrpm.by_srpm_name(params[:srpm_id]).includes(:branch_path, :srpm, :branch).order('branches.order_id'))
  end
end
