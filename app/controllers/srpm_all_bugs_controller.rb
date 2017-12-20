# frozen_string_literal: true

class SrpmAllBugsController < ApplicationController
  # after_action :print_accessed_fields

  def index
    @branch = Branch.find_by!(name: params[:branch])
    @srpm = @branch.srpms.find_by!(name: params[:id])
    @all_bugs = AllBugsForSrpm.new(@srpm).decorate
    @opened_bugs = OpenedBugsForSrpm.new(@srpm).decorate
  end

  # private
  #
  # def print_accessed_fields
  #   # p @users.first.accessed_fields
  #
  #   p @branch.accessed_fields
  #
  #   p @srpm.accessed_fields
  #
  #   p @all_bugs.first.accessed_fields
  #
  #   p @opened_bugs.first.accessed_fields
  # end
end
