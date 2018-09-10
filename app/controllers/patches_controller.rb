# frozen_string_literal: true

class PatchesController < ApplicationController
  before_action :set_version
  before_action :fetch_srpm
  before_action :fetch_srpms_by_name, only: %i(index)

  def index
    @all_bugs = AllBugsForSrpm.new(@srpm).decorate
    @opened_bugs = OpenedBugsForSrpm.new(@srpm).decorate
  end

  def show
    @patch = @srpm.patches.find_by!(filename: params[:id])
    raise ActiveRecord::RecordNotFound unless @patch.patch
    # @html_data = Rouge::Formatters::HTML.new(css_class: 'highlight', line_numbers: true, inline_theme: 'github').format(Rouge::Lexers::Diff.new.lex(@patch.patch))

    @html_data = Rouge::Formatters::HTMLLegacy.new(css_class: 'highlight', line_numbers: true).format(Rouge::Lexers::Diff.new.lex(@patch.patch))
  end

  protected

  def fetch_srpm
    includes = {
       index: %i(patches),
    }[action_name.to_sym]

    srpms = @branch.spkgs.by_name(params[:srpm_id]).by_evr(params[:version])
    srpms = srpms.includes(*includes) if includes
    
    @srpm = srpms.first!.decorate
  end

  def fetch_srpms_by_name
    @srpms_by_name = SrpmBranchesSerializer.new(Rpm.by_name(params[:srpm_id]).includes(:branch_path, :package, :branch).order('branches.order_id'))
  end

  def set_version
    @version = params[:version]
  end
end
