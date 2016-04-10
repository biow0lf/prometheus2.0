class PatchesController < ApplicationController
  def index
    @branch = Branch.find_by!(name: params[:branch])
    @srpm = @branch.srpms.where(name: params[:srpm_id]).includes(:patches).first!
    @allsrpms = Srpm.where(name: params[:srpm_id]).includes(:branch).order('branches.order_id').decorate
  end

  def show
    @branch = Branch.find_by!(name: params[:branch])
    @srpm = @branch.srpms.find_by!(name: params[:srpm_id])
    @patch = @srpm.patches.find_by!(filename: params[:id])
    raise ActiveRecord::RecordNotFound unless @patch.patch
    @html_data = Rouge::Formatters::HTML.new(css_class: 'highlight', line_numbers: true, inline_theme: 'github').format(Rouge::Lexers::Diff.new.lex(@patch.patch))
  end
end
